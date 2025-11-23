resource "azurerm_linux_virtual_machine" "linux_virtual_machines" {
  for_each = var.linux_virtual_machines

  name                = each.value.name
  location            = var.o_rg_dtls[each.value.rg_key].location
  resource_group_name = var.o_rg_dtls[each.value.rg_key].name
  admin_username      = var.o_key_vault_secret_dtls[each.value.username_secret_key].value
  admin_password      = var.o_key_vault_secret_dtls[each.value.password_secret_key].value
  network_interface_ids = [
    for key in each.value.nic_keys :
    var.o_nic_dtls[key].id
  ]

  size = each.value.vm_size

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  tags = lookup(each.value, "tags", null)

}
