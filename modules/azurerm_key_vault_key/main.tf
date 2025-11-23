resource "azurerm_key_vault_key" "key_vault_keys" {
  for_each = var.key_vault_keys

  name         = each.value.name
  key_vault_id = var.o_keyvault_dtls[each.value.kv_key].id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts

}
