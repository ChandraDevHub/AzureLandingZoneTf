variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    name   = string
    rg_key = string
    # location            = string
    # resource_group_name = string
    address_space = list(string)
    dns_servers   = optional(list(string), [])
    # subnets = map(object({
    #   name             = string
    #   address_prefixes = list(string)
    # }))
    tags = optional(map(string), {})
  }))
}
variable "o_rg_dtls" {
  description = "Resource Group output map"
  type = map(object({
    name     = string
    location = string
  }))
}

