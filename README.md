# 🔧 Terraform Azure Infrastructure

This project manages Azure infrastructure using Terraform, following best practices for modularity, remote state, and environment separation.

---

## 📝 What Was Done in This Research

This repository demonstrates how to build a scalable and maintainable Azure infrastructure using Terraform. The main achievements and steps in this research include:

- **Remote State Management:**  
  All environments use Azure Blob Storage for remote state, ensuring safe collaboration and state locking.

- **Environment Separation:**  
  Infrastructure is split into multiple environments (`bootstrap`, `dev`, `security`) to separate concerns and allow independent deployments.

- **Modular Design:**  
  Core resources (VM, Disk, NSG) are implemented as reusable modules, making it easy to extend or replicate infrastructure.

- **Resource Provisioning Workflow:**  
  1. **Bootstrap:**  
     Sets up the foundational resources: resource group, storage account, container, virtual network, and subnet.  
     Outputs (like subnet ID, location, and resource group name) are shared via remote state for use in other environments.
  2. **Dev:**  
     Deploys a Linux VM using the `vm` module. The VM is provisioned in the subnet created by bootstrap, and uses remote state outputs for resource group, location, and subnet.  
     Also demonstrates how to add a managed disk using a dedicated module, with parameters managed via `.tfvars`.
  3. **Security:**  
     Creates a Network Security Group (NSG) and associates it with the subnet. The NSG configuration (name, rules) is parameterized and can be managed via `.tfvars`.  
     The NSG uses remote state outputs for location and resource group.

- **Parameterization with tfvars:**  
  All sensitive and environment-specific values (like subscription ID, admin credentials, disk size, NSG name) are managed via `.tfvars` files for each environment.

- **Output Sharing:**  
  Key outputs (resource group name, location, subnet ID, VM ID, disk ID, etc.) are exposed in each environment and module, enabling cross-environment references and automation.

- **Best Practices:**  
  - Sensitive data is kept out of code and managed via variables.
  - State files are never committed to version control.
  - Provider versions are locked for reproducibility.
  - Clear deployment order is documented to avoid dependency issues.

---

## 📂 Folder Structure

```
terraform/
├── bootstrap/        # Initial setup (VNet, Subnet, RG, Storage Account)
├── environments/
│   ├── dev/          # Deploys VM and disk using reusable modules
│   └── security/     # Creates and associates NSG to Subnet
├── modules/
│   ├── vm/           # VM module used by environments/dev
│   └── disk/         # Disk module used by environments/dev
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

2. **Dev** (VM and disk deployment using modules)

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

* [`modules/vm`](modules/vm): Defines a Linux VM with public IP, NIC, and disk.
* [`modules/disk`](modules/disk): Defines a managed disk resource.

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
* Disk IDs and names

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