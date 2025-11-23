resource "azurerm_route_table" "route_tables" {
  for_each = var.route_tables

  name                = each.value.name
  location            = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name = var.o_rg_dtls[each.value.rg_key].name
}