subscription_id      = "00000000-0000-0000-0000-000000000000"
project_name         = "dev"
location             = "eastus"
resource_group_name  = "dev-rg"

space = ["10.0.0.0/16"]

subnets = [
  { name = "subnet-app",  address = "10.0.2.0/24" },
  { name = "subnet-db",   address = "10.0.3.0/24" }
]

enable_ngw = false

vms = [
  {
    vm_name      = "app-vm"
    vm_user      = "azureuser"
    vm_pass      = "YourSecurePassword123!"
    vm_size      = "Standard_B2s"
    subnet       = "subnet-app"
    disk_name    = "dev-disk-1"
    disk_size    = 32
    disk_sku     = "Standard_LRS"
    caching      = "ReadWrite"
    lun          = 1
    os_publisher = "Canonical"
    os_offer     = "0001-com-ubuntu-server-jammy"
    os_sku       = "24_04-lts-gen2"
    os_version   = "latest"
    encryption   = null
    ephemeral    = false
    location     = "eastus"
    rg_name      = "dev-rg"
    nsg_name     = "nsg-dev-vm-1"
    sec_rules = [
      {
        name         = "AllowSSH"
        priority     = 1001
        direction    = "Inbound"
        access       = "Allow"
        protocol     = "Tcp"
        src_port     = "*"
        dest_port    = "22"
        src_address  = "*"
        dest_address = "*"
      }
    ]
  },
  {
    vm_name      = "db-vm"
    vm_user      = "azureuser"
    vm_pass      = "YourSecurePassword123!"
    vm_size      = "Standard_B2s"
    subnet       = "subnet-db"
    disk_name    = "dev-disk-2"
    disk_size    = 64
    disk_sku     = "Standard_LRS"
    caching      = "ReadWrite"
    lun          = 2
    os_publisher = "Canonical"
    os_offer     = "0001-com-ubuntu-server-jammy"
    os_sku       = "24_04-lts-gen2"
    os_version   = "latest"
    encryption   = null
    ephemeral    = false
    location     = "eastus"
    rg_name      = "dev-rg"
    nsg_name     = "nsg-dev-vm-2"
    sec_rules = [
      {
        name         = "AllowSSH"
        priority     = 1001
        direction    = "Inbound"
        access       = "Allow"
        protocol     = "Tcp"
        src_port     = "*"
        dest_port    = "22"
        src_address  = "*"
        dest_address = "*"
      }
    ]
  }
]