# 🔧 Terraform Azure Infrastructure

This project manages Azure infrastructure using Terraform with best practices such as:

* Remote state management in Azure Blob Storage
* Modular and reusable infrastructure
* Multi-environment separation (`bootstrap`, `dev`, `security`)
* Separation of concerns using Terraform modules (`vm`, and more coming)

---

## 📂 Folder Structure

```
terraform/
├── bootstrap/        # Initial setup (VNet, Subnet, RG, Storage Account)
├── environments/
│   ├── dev/          # Deploys VM using reusable modules
│   └── security/     # Creates and associates NSG to Subnet
├── modules/
│   └── vm/           # VM module used by environments/dev
```

---

## ☁️ Azure Setup

Before running Terraform, you must login and prepare remote backend state storage.

### 🔑 Login to Azure

```bash
az login --use-device-code
```

> Make sure your account has permission to create resource groups, storage accounts, networks, and VMs.

---

## 🛣️ Remote State Configuration

The backend is configured in each environment’s `backend.tf` like this:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-research-terraform"
    storage_account_name = "research9tfstate"
    container_name       = "tfstate"
    key                  = "<env>.terraform.tfstate"
  }
}
```

Example keys used:

* `bootstrap.terraform.tfstate`
* `dev.terraform.tfstate`
* `security.terraform.tfstate`

> Remote state is automatically locked during operations to prevent concurrency issues.

---

## 🚀 Deployment Order

> ⚠️ **Run in the following order**

1. **Bootstrap** (resource group, storage account, VNet, Subnet)

```bash
cd bootstrap
terraform init
terraform apply
```

2. **Dev** (VM deployment using `modules/vm`)

```bash
cd environments/dev
terraform init
terraform apply
```

3. **Security** (NSG creation and attach to subnet)

```bash
cd environments/security
terraform init
terraform apply
```

---

## 📦 Modules

Currently available:

* [`modules/vm`](modules/vm): Defines a Linux VM with public IP, NIC, and disk. Can be extended.

---

## 🔒 Network Security Group (NSG)

* NSG is created and attached to the subnet used by the VM.
* All VMs inside the subnet will follow NSG rules (e.g. SSH access).

> If needed, you can change this to attach NSG to a specific NIC.

---

## 📬 Outputs

Each environment defines its own `outputs.tf`. Common outputs include:

* Resource group names
* Subnet IDs
* VM IDs, NICs, NSG IDs

These outputs are accessed across environments using:

```hcl
data "terraform_remote_state" "bootstrap" {
  backend = "azurerm"
  config = {
    resource_group_name  = "..."
    storage_account_name = "..."
    container_name       = "..."
    key                  = "bootstrap.terraform.tfstate"
  }
}
```

---

## 📌 Notes

* Keep sensitive data (passwords, tokens) in Key Vault or use Terraform Cloud Variables
* `.terraform.tfstate` is stored remotely — **do not commit `.tfstate` to Git**
* `.terraform.lock.hcl` should be committed to lock provider versions
* Always run `terraform plan` before `terraform apply`

---

## ✅ Prerequisites

* Terraform CLI v1.3+
* Azure CLI (`az`)
* Logged in Azure account with appropriate permissions
* Resource Group and Storage Account will be created by bootstrap

---

## 🧪 Testing

To test remote state integration:

```bash
terraform init
terraform plan
terraform state list
terraform state show <resource>
```