resource "azurerm_network_interface" "network_interfaces" {
  for_each = var.network_interfaces

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = var.o_subnet_dtls[each.value.subnet_key].id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }

  tags = lookup(each.value, "tags", null)
}