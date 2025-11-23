resource "azurerm_subnet_route_table_association" "subnet_rt_assocs" {
  for_each = var.subnet_rt_assocs

  subnet_id      = var.o_subnet_dtls[each.value.subnet_key].id
  route_table_id = var.o_route_table_dtls[each.value.rt_key].id
}
