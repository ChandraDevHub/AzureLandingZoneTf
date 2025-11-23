variable "subnet_nsg_association" {
  description = "subnet and network secirity group association"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}
variable "o_subnet_dtls" {
  description = "output subnet map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_nsg_dtls" {
  description = "output network security group map"
  type = map(object({
    id   = string
    name = string
  }))
}