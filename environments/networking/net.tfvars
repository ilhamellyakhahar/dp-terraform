subs_id      = "subs"        
project_name = "research-ilham"
location     = "southeastasia"
rg_name      = "rg-ilhamellya"

space = [
  "10.1.0.0/16"
]

subnets = [
  {
    name    = "subnet1"
    address = "10.1.2.0/24"
  }
]

enable_ngw = false
