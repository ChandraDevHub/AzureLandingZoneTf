resource "azurerm_storage_account" "storage_accounts" {
  for_each = var.storage_accounts

  name                     = each.value.name
  resource_group_name      = var.o_rg_dtls[each.value.rg_key].name
  location                 = var.o_rg_dtls[each.value.rg_key].location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = lookup(each.value, "tags", null)
}