output "o_vnet_dtls" {
  description = "Map of VNet ID and Name"
  value = {
    for key, vnet in azurerm_virtual_network.virtual_networks :
    key => {
      id      = vnet.id
      name    = vnet.name
    #   subnets = vnet.subnets
    }
  }
}
