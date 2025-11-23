resource "azurerm_key_vault_secret" "kv_secrets" {
  for_each = var.key_vault_secrets

  name         = each.value.secret_name
  value        = each.value.value
  key_vault_id = var.o_keyvault_dtls[each.value.kv_key].id
}