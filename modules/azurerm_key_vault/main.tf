resource "azurerm_key_vault" "key_vaults" {
  for_each = var.key_vaults

  name                        = each.value.kv_name
  location                    = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name         = var.o_rg_dtls[each.value.rg_key].name
  sku_name                    = each.value.sku_name
  tenant_id                   = var.tenant_id   #data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tags                        = lookup(each.value, "tags", null)
  dynamic "access_policy" {
    for_each = lookup(each.value, "access_policies", [])
    content {
      tenant_id           = var.tenant_id   #data.azurerm_client_config.current.tenant_id
      object_id           = var.object_id   #data.azurerm_client_config.current.object_id
      key_permissions     = access_policy.value.key_permissions
      secret_permissions  = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }
}
