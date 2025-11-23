variable "role_assignments" {
  description = "Azure Role assignments"
  type = map(object({
    kv_key               = string
    role_definition_name = string
  }))
}
variable "o_keyvault_dtls" {
  description = "output key vault details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "des_principal_id" {
  description = "principal Id from the disk encryption set"
  type        = string
}
