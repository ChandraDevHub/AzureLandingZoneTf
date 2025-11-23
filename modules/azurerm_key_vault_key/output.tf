output "o_keyvault_key_dtls" {
  value = {
    for kv_key_key, kv in azurerm_key_vault_key.key_vault_keys :
    kv_key_key => {
      id   = kv.id
      name = kv.name
    }
  }
}
