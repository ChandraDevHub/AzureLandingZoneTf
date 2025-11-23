resource "azurerm_bastion_host" "bastion_hosts" {
  for_each = var.bastion_hosts

  name                = each.value.name
  location            = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name = var.o_rg_dtls[each.value.rg_key].name
  virtual_network_id  = var.o_vnet_dtls[each.value.vnet_key].id
  sku                 = each.value.sku
  ip_configuration {
    name                 = each.value.ip_configuration.name
    subnet_id            = var.o_subnet_dtls[each.value.ip_configuration.subnet_key].id
    public_ip_address_id = var.o_public_ip_dtls[each.value.ip_configuration.public_ip_key].id
  }
  tags = each.value.tags
}
