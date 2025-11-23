output "o_nsg_dtls" {
  value = {
    for nsg_key, nsg in azurerm_network_security_group.security_groups :
    nsg_key => {
      id   = nsg.id
      name = nsg.name
    }
  }
}
