output "o_disk_encryption_set_dtls" {
  description = "Map of Disk Encryption Set IDs and names"
  value = {
    for des_key, des in azurerm_disk_encryption_set.disk_encryption_sets :
    des_key => {
      id        = des.id
      name      = des.name
      tenant_id = des.identity[0].tenant_id
      principal_id = des.identity[0].principal_id
    }
  }
}
