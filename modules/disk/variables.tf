variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "size_gb" {
  type = number
}

variable "sku" {
  type = string
}

variable "caching" {
  type = string
}

variable "lun" {
  type = number
}