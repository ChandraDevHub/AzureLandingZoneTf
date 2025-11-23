variable "subnet_rt_assocs" {
  description = "subnet route table association"
  type = map(object({
    subnet_key = string
    rt_key     = string
  }))
}
variable "o_subnet_dtls" {
  description = "output subnet details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_route_table_dtls" {
    description = "output Route table details map"
    type = map(object({
        id   = string
        name = string
    }))
  
}