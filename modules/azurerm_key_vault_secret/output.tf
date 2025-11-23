output "o_key_vault_secret_dtls" {
  value = {
    for kvs_key, kvs in azurerm_key_vault_secret.kv_secrets :
    kvs_key => {
      id    = kvs.id
      name  = kvs.name
      value = kvs.value
    }
  }
}
