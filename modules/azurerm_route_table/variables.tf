variable "route_tables" {
  description = "Route table"
  type = map(object({
    name   = string
    rg_key = string
  }))
}
variable "o_rg_dtls" {
  description = "output resource group details map"
  type = map(object({
    name     = string
    location = string
  }))
}
