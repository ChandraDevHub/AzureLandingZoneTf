variable "key_vault_keys" {
  description = "Map of Key Vault Keys to create"
  type = map(object({
    name         = string
    kv_key       = string                     # Key Vault reference key
    key_type     = string                     # e.g., RSA, RSA-HSM, EC
    key_size     = optional(number)           # only for RSA keys
    key_opts     = list(string)               # operations allowed
  }))
}
variable "o_keyvault_dtls" {
  description = "output key vault map"
  type = map(object({
    id   = string
    name = string
  }))
}
