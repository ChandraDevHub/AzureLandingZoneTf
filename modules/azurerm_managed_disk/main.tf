resource "azurerm_managed_disk" "managed_disks" {
  for_each = var.managed_disks
    name                 = each.value.name
    location             = var.o_rg_dtls[each.value.rg_key].location
    resource_group_name  = var.o_rg_dtls[each.value.rg_key].name
    storage_account_type = each.value.storage_account_type
    disk_size_gb        = each.value.disk_size_gb
    create_option        = each.value.create_option
    tags                 = lookup(each.value, "tags", null)
}