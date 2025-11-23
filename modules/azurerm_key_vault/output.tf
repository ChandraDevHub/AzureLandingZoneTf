output "o_keyvault_dtls" {
  value = {
    for kv_key, kv in azurerm_key_vault.key_vaults :
    kv_key => {
      id   = kv.id
      name = kv.name
    }
  }
}
