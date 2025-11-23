variable "key_vaults" {
  description = "Map of Key Vaults"
  type = map(object({
    kv_name = string
    rg_key  = string  #rg_name aur location ke liye hai
    # location       = string
    # rg_name        = string
    enabled_for_disk_encryption = bool
    # tenant_id                   = string
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool

    sku_name = string

    tags = optional(map(string), {})

    # Access policies (optional, but recommended to make it dynamic)
    access_policies = optional(list(object({
    #   tenant_id           = string
    #   object_id           = string
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    })), [])
  }))
}
variable "o_rg_dtls" {
  description = "output resource group map"
  type = map(object({
    name     = string
    location = string
  }))
}
variable "tenant_id" {
  description = "Tenant Id from the client config"
  type = string
}
variable "object_id" {
  description = "Object Id from the client config"
  type = string
}