variable "public_ips" {
  description = "Public IP for Azure Resources"
  type = map(object({
    name   = string
    rg_key = string
    # location            = string
    # resource_group_name = string
    allocation_method = string
    tags              = optional(map(string), {})
  }))
}
variable "o_rg_dtls" {
  description = "Resource Group output map"
  type = map(object({
    name     = string
    location = string
  }))
}
