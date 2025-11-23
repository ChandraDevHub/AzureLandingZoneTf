resource "azurerm_firewall" "firewalls" {
  for_each = var.firewalls

  name                = each.value.name
  location            = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name = var.o_rg_dtls[each.value.rg_key].name
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier

  ip_configuration {
    name                 = each.value.ip_configuration.name
    subnet_id            = var.o_subnet_dtls[each.value.ip_configuration.subnet_key].id
    public_ip_address_id = var.o_public_ip_dtls[each.value.ip_configuration.public_ip_key].id
  }
}
