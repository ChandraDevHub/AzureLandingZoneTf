variable "bastion_hosts" {
  description = "Bastion Host"
  type = map(object({
    name = string
    # location   = string
    rg_key   = string
    vnet_key = string
    sku      = string
    tags     = optional(map(string), {})
    ip_configuration = object({
      name          = string
      subnet_key    = string
      public_ip_key = string
    })
  }))
}
variable "o_rg_dtls" {
  description = "output resource group map"
  type = map(object({
    name     = string
    location = string
  }))
}
variable "o_vnet_dtls" {
  description = "output virtual network map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_subnet_dtls" {
  description = "output subnet map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_public_ip_dtls" {
  description = "output public ip map"
  type = map(object({
    id   = string
    name = string
  }))
}
