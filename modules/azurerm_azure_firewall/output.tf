output "o_firewall_dtls" {
  value = {
    for fw_key, fw in azurerm_firewall.firewalls :
    fw_key => {
      id         = fw.id
      name       = fw.name
      private_ip = fw.ip_configuration[0].private_ip_address
    }
  }
}
