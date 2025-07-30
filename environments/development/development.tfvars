rg_name      = "dev-rg-override"
location     = "eastus"
project_name = "dev-project-override"
enable_ngw   = false

vms = [
  {
    vm_name    = "override-vm1"
    vm_user    = "azureuser"
    vm_pass    = "OverridePass!"
    vm_size    = "Standard_B1ms"
    subnet     = "subnet2"
    disk_name  = "override-disk1"
    disk_size  = 50
    disk_sku   = "Premium_LRS"
    caching    = "ReadOnly"
    lun        = 1
    os_publisher = "Canonical"
    os_offer   = "UbuntuServer"
    os_sku     = "20.04-LTS"
    os_version = "latest"
    location   = "eastus"
    rg_name    = "dev-rg-override"
    public_ip  = true
  }
]
