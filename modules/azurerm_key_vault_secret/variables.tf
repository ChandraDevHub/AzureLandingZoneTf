variable "key_vault_secrets" {
  description = "Azure Key Vault Secrets"
  type = map(object({
    secret_name = string #KV_Key
    value       = string
    kv_key      = string
  }))
}
variable "o_keyvault_dtls" {
  description = "key vault output map"
  type = map(object({
    id   = string
    name = string
  }))
}
