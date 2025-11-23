resource "azurerm_role_assignment" "role_assignments_disk" {
  for_each = var.role_assignments

  scope                = var.o_keyvault_dtls[each.value.kv_key].id
  role_definition_name = each.value.role_definition_name
  principal_id         = var.des_principal_id
}