variable "project_name" {
  description = "Project prefix name for resources"
  type        = string
}

variable "location" {
  description = "Azure region/location"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "space" {
  description = "Virtual network address space"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name    = string
    address = string
  }))
}

variable "enable_ngw" {
  description = "Enable NAT Gateway"
  type        = bool
}
