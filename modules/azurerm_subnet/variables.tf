variable "subnets" {
  description = "Subnets for Azure Resources"
  type = map(object({
    name             = string
    rg_key           = string
    vnet_key         = string
    address_prefixes = list(string)
  }))
}
variable "o_rg_dtls" {
  description = "Resource Group output map"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "o_vnet_dtls" {
  description = "Virtual Network output map"
  type = map(object({
    id   = string
    name = string
  }))
}
