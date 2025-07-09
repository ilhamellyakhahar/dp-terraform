variable "project_name" {
  type        = string
}

variable "location" {
  type        = string
}

variable "rg_name" {
  type        = string
}

variable "space" {
  type        = list(string)
}

variable "subnets" {
  type = list(object({
    name            = string
    address         = string
  }))
}

variable "enable_ngw" {
  type        = bool
  default     = false
}