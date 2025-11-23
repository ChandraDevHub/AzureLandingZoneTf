variable "managed_disks" {
  description = "Managed disk"
  type = map(object({
    name                 = string
    rg_key               = string
    storage_account_type = string
    create_option        = string
    disk_size_gb         = number
    tags                 = optional(map(string), {})
  }))
}
variable "o_rg_dtls" {
  description = "output resource group details map"
  type = map(object({
    name     = string
    location = string
  }))
}
