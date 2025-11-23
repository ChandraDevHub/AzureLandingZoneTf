output "o_public_ip_dtls" {
  description = "Details of all created Public IPs"
  value = {
    for k, v in azurerm_public_ip.public_ips :
    k => {
      id                = v.id
      name              = v.name
    }
  }
}
