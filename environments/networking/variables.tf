variable "subs_id" {
  description = "Azure Subscription ID"
  type        = string
}

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
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name    = string
    address = string
  }))
  default = [
    {
      name    = "subnet1"
      address = "10.0.1.0/24"
    }
  ]
}


variable "enable_ngw" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = false
}
