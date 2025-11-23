variable "key_vault_access_policies" {
  description = "Key vault access policies"
  type = map(object({
    kv_key          = string
    key_permissions = list(string)
  }))
}
variable "o_keyvault_dtls" {
  description = "output key vault details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "des_tenant_id" {
  description = "Tenant Id from the client config"
  type        = string
}
variable "des_object_id" {
  description = "Object Id from the client config"
  type        = string
}
