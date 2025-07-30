module "network" {
  source      = "../../modules/network"
  project_name = var.project_name
  location     = var.location
  rg_name      = var.rg_name
  space        = var.space
  subnets      = var.subnets
  enable_ngw   = var.enable_ngw
}
