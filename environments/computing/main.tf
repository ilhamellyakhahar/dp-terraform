locals {
  vms_with_subnet = [
    for vm in var.vms : merge(vm, {
      subnet   = data.terraform_remote_state.networking.outputs.subnet_ids["subnet1"]
      vm_name  = var.name
      vm_user  = var.username
      vm_pass  = var.password
      location = var.location
      public_ip = var.public_ip
      disk_name = "${var.name}-disk"
      disk_size = var.disk_size
      rg_name   = var.rg_name
      sec_rules = var.sec_rules
      nsg_name = "${var.name}-nsg"
    })
  ]
}

module "compute" {
  source = "../../modules/compute"
  vms    = local.vms_with_subnet
}