name  = "vmtest"
username  = "ilhamya"
password  = "Alamat9N3st"
location  = "southeastasia"
public_ip = true
disk_size = 32
rg_name   = "rg-ilhamellya"
subs_id   = "subs"
sec_rules = [
  {
    name         = "Allow-SSH"
    priority     = 100
    direction    = "Inbound"
    access       = "Allow"
    protocol     = "Tcp"
    src_port     = "*"
    dest_port    = "22"
    src_address  = "4.194.148.36"
    dest_address = "*"
  },
  {
    name         = "Allow-HTTP"
    priority     = 200
    direction    = "Inbound"
    access       = "Allow"
    protocol     = "Tcp"
    src_port     = "*"
    dest_port    = "80"
    src_address  = "*"
    dest_address = "*"
  },
  {
    name         = "Allow-HTTPS"
    priority     = 300
    direction    = "Inbound"
    access       = "Allow"
    protocol     = "Tcp"
    src_port     = "*"
    dest_port    = "443"
    src_address  = "*"
    dest_address = "*"
  }
]
