variable "security_groups" {
  description = "Network Security Groups"
  type = map(object({
    name   = string
    rg_key = string
    # location = string
    # rg_name  = string
    tags = optional(map(string))
    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
    })), [])
  }))
}
variable "o_rg_dtls" {
  description = "Resource Group output map"
  type = map(object({
    name     = string
    location = string
  }))
}
