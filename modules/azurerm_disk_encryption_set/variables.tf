variable "disk_encryption_sets" {
  description = "Disk encryption sets"
  type = map(object({
    name          = string
    rg_key        = string
    kv_key_key    = string
    identity_type = optional(string, "SystemAssigned")
    tags          = optional(map(string), {})
  }))
}
variable "o_keyvault_key_dtls" {
  description = "output Key vault key details map"
  type = map(object({
    id   = string
    name = string
  }))
}
variable "o_rg_dtls" {
  description = "output resource group map"
  type = map(object({
    name     = string
    location = string
  }))
}
