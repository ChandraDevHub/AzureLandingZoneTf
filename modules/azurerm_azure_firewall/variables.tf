variable "firewalls" {
  description = "Azure firewall for my subnet"
  type = map(object({
    name     = string
    rg_key   = string
    sku_name = string
    sku_tier = string

    ip_configuration = object({
      name          = string
      subnet_key    = string
      public_ip_key = string
    })
  }))
}
variable "o_rg_dtls" {
  description = "output resource group details map"
  type = map(object({
    name     = string
    location = string
  }))
}
variable "o_subnet_dtls" {
  description = "output subnet details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_public_ip_dtls" {
  description = "output public ip details map"
  type = map(object({
    id   = string
    name = string
  }))
}

