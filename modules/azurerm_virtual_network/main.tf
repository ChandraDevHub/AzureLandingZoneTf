resource "azurerm_virtual_network" "virtual_networks" {
  for_each = var.virtual_networks

  name                = each.value.name
  location            = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name = var.o_rg_dtls[each.value.rg_key].name
  address_space       = each.value.address_space
  dns_servers         = lookup(each.value, "dns_servers", null)

  tags = lookup(each.value, "tags", null)

  # dynamic "subnet" {
  #   for_each = each.value.subnets
  #   content {
  #     name             = subnet.value.name
  #     address_prefixes = subnet.value.address_prefixes
  #   }
  # }
}
