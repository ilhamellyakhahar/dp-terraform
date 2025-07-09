subscription_id      = "00000000-0000-0000-0000-000000000000"
vm_name              = "dev-vm"
admin_username       = "azureuser"
admin_password       = "YourSecurePassword123!"
disk_name            = "dev-disk"
disk_size_gb         = 32
disk_sku             = "Standard_LRS"
caching              = "ReadWrite"
lun                  = 1
project_name         = "dev"
address_space        = ["10.0.0.0/16"]
subnets = [
  { name = "subnet-vmtf", address_prefix = "10.0.1.0/24" },
  { name = "subnet-app",  address_prefix = "10.0.2.0/24" },
  { name = "subnet-db",   address_prefix = "10.0.3.0/24" }
]
subnet_name          = "subnet-app"
enable_nat_gateway   = false