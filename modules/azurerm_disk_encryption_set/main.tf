resource "azurerm_disk_encryption_set" "disk_encryption_sets" {
  for_each = var.disk_encryption_sets

  name                = each.value.name
  location            = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name = var.o_rg_dtls[each.value.rg_key].name
  key_vault_key_id    = var.o_keyvault_key_dtls[each.value.kv_key_key].id
  identity {
    type = each.value.identity_type
  }
}
