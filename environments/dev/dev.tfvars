subscription_id      = "00000000-0000-0000-0000-000000000000"
project_name         = "dev"
location             = "eastus"
resource_group_name  = "dev-rg"

address_space        = ["10.0.0.0/16"]

subnets = [
  { name = "subnet-vmtf", address_prefix = "10.0.1.0/24" },
  { name = "subnet-app",  address_prefix = "10.0.2.0/24" },
  { name = "subnet-db",   address_prefix = "10.0.3.0/24" }
]

enable_nat_gateway   = false

vms = [
  {
    name                    = "dev-vm"
    admin_username          = "azureuser"
    admin_password          = "YourSecurePassword123!"
    vm_size                 = "Standard_B2s"
    subnet_name             = "subnet-app"
    disk_name               = "dev-disk"
    disk_size_gb            = 32
    disk_sku                = "Standard_LRS"
    caching                 = "ReadWrite"
    lun                     = 1
    os_publisher            = "Canonical"
    os_offer                = "0001-com-ubuntu-server-jammy"
    os_sku                  = "24_04-lts-gen2"
    os_version              = "latest"
    disk_encryption_set_id  = null
    use_ephemeral_os_disk   = false
    location                = "eastus"
    rg_name                 = "dev-rg"
    nsg_name                = "nsg-dev-vm"
    security_rules = [
      {
        name                       = "AllowSSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
]