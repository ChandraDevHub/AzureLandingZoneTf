resource "azurerm_route" "nw_routes" {
  for_each = var.nw_routes

  name                   = each.value.name
  resource_group_name    = var.o_rg_dtls[each.value.rg_key].name
  route_table_name       = var.o_route_table_dtls[each.value.rt_key].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = var.o_firewall_dtls[each.value.firewall_key].private_ip

}
