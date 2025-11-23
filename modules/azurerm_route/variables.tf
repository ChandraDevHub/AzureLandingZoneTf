variable "nw_routes" {
  description = "Network routes"
  type = map(object({
    name           = string
    rt_key         = string
    rg_key         = string
    firewall_key   = string
    address_prefix = string
    next_hop_type  = string
  }))
}
variable "o_rg_dtls" {
  description = "output resource group details map"
  type = map(object({
    name     = string
    location = string
  }))
}
variable "o_route_table_dtls" {
  description = "output Route table details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_firewall_dtls" {
  description = "output firewall details map"
  type = map(object({
    id         = string
    name       = string
    private_ip = string
  }))
}
