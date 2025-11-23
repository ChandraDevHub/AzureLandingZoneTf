resource "azurerm_key_vault_access_policy" "key_vault_access_policies" {
  for_each = var.key_vault_access_policies

  key_vault_id = var.o_keyvault_dtls[each.value.kv_key].id
  tenant_id    = var.des_tenant_id
  object_id    = var.des_object_id

  key_permissions = each.value.key_permissions
}
