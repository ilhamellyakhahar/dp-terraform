variable "location" {
  default = "Southeast Asia"
}

variable "resource_group_name" {
  default = "rg-research-terraform"
}

variable "storage_account_name" {
  default = "research9tfstate"
}

variable "container_name" {
  default = "tfstate"
}

variable "vnet_name" {
  default = "vnet-tf"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default = "subnet-vmtf"
}

variable "subnet_prefix" {
  default = "10.0.1.0/24"
}