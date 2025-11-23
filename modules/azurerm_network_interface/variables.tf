variable "network_interfaces" {
  description = "Network Interfaces"
  type = map(object({
    name       = string
    location   = string
    rg_name    = string
    subnet_key = string
    ip_configuration = object({
      name                          = string
      private_ip_address_allocation = string
    })

    tags = optional(map(string), {})
  }))
}
variable "o_subnet_dtls" {
  description = "Subnet output map"
  type = map(object({
    id   = string
    name = string
  }))
}