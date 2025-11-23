output "o_subnet_dtls" {
  value = {
    for sn_key, sn in azurerm_subnet.subnets :
    sn_key => {
      id   = sn.id
      name = sn.name
    }
  }
}
