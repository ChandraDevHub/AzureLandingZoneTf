output "o_nic_dtls" {
  value = {
    for nic_key, nic in azurerm_network_interface.network_interfaces :
    nic_key => {
      id   = nic.id
      name = nic.name
    }
  }
}
