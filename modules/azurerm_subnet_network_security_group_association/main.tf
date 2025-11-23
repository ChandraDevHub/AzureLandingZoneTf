resource "azurerm_subnet_network_security_group_association" "subnet_nsg_associations" {
  for_each = var.subnet_nsg_association

  subnet_id                 = var.o_subnet_dtls[each.value.subnet_key].id
  network_security_group_id = var.o_nsg_dtls[each.value.nsg_key].id
  
}