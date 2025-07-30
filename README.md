Modules capability

**Compute:**
- Multiple VMs
- Data Disk (Optional)
- NSG configuration
- Credentials (Password or SSH key)

**Network:**
- Multiple Subnets
- Nat Gateway

---

## Test Scenario

1. Provision resource group and blob storage from portal
2. Provision networking environment with network module
3. Provision VM with value from networking environment tfstate

---

## Documentation

### 1. Networking Environment

```sh
$ terraform apply -var-file=net.tfvars
```

Output:

```
Acquiring state lock. This may take a few moments...

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.network.azurerm_subnet.subnet["subnet1"] will be created
  + resource "azurerm_subnet" "subnet" {
      + address_prefixes                              = [
          + "10.1.2.0/24",
        ]
      + default_outbound_access_enabled               = true
      + id                                            = (known after apply)
      + name                                          = "subnet1"
      + private_endpoint_network_policies             = "Disabled"
      + private_link_service_network_policies_enabled = true
      + resource_group_name                           = "rg-ilhamellya"
      + virtual_network_name                          = "research-ilham-vnet"
    }

  # module.network.azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space                  = [
          + "10.1.0.0/16",
        ]
      + dns_servers                    = (known after apply)
      + guid                           = (known after apply)
      + id                             = (known after apply)
      + location                       = "southeastasia"
      + name                           = "research-ilham-vnet"
      + private_endpoint_vnet_policies = "Disabled"
      + resource_group_name            = "rg-ilhamellya"
      + subnet                         = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + subnet_ids       = {
      + subnet1 = (known after apply)
    }
  + subnet_names     = [
      + "subnet1",
    ]
  + vnet_id          = (known after apply)
  + vnet_name        = "research-ilham-vnet"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.network.azurerm_virtual_network.vnet: Creating...
module.network.azurerm_virtual_network.vnet: Still creating... [00m10s elapsed]
module.network.azurerm_virtual_network.vnet: Creation complete after 14s [id=/subscriptions/{subsid}/resourceGroups/rg-ilhamellya/providers/Microsoft.Network/virtualNetworks/research-ilham-vnet]
module.network.azurerm_subnet.subnet["subnet1"]: Creating...
module.network.azurerm_subnet.subnet["subnet1"]: Still creating... [00m10s elapsed]
module.network.azurerm_subnet.subnet["subnet1"]: Creation complete after 14s [id=/subscriptions/{subsid}/resourceGroups/rg-ilhamellya/providers/Microsoft.Network/virtualNetworks/research-ilham-vnet/subnets/subnet1]
Releasing state lock. This may take a few moments...

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

subnet_ids = {
  "subnet1" = "/subscriptions/{subsid}/resourceGroups/rg-ilhamellya/providers/Microsoft.Network/virtualNetworks/research-ilham-vnet/subnets/subnet1"
}
subnet_names = [
  "subnet1",
]
vnet_id = "/subscriptions/{subsid}/resourceGroups/rg-ilhamellya/providers/Microsoft.Network/virtualNetworks/research-ilham-vnet"
vnet_name = "research-ilham-vnet"
```

---

Verification (from portal):

**Virtual Network Overview**  
![Vnet](images/vnet.png)

**Subnet Overview**  
![Subnet](images/subnet.png)