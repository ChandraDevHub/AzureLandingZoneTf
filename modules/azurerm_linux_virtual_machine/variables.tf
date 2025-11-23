variable "linux_virtual_machines" {
  description = "Virtual Machines"
  type = map(object({
    name                = string
    rg_key              = string
    nic_keys            = list(string)
    vm_size             = string
    username_secret_key = string
    password_secret_key = string
    #network_interface_id = list(string)
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    disable_password_authentication = bool
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    tags = optional(map(string), {})
  }))
}
variable "o_rg_dtls" {
  description = "output resource group details map"
  type = map(object({
    name     = string
    location = string
  }))
}
variable "o_nic_dtls" {
  description = "output network interface card details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_key_vault_secret_dtls" {
  description = "output key vault secret details map"
  type = map(object({
    id    = string
    name  = string
    value = string
  }))
}
