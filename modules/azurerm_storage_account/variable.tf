variable "storage_accounts" {
  description = "storage account"
  type = map(object({
    name                     = string
    rg_key                   = string
    account_tier             = string
    account_replication_type = string
    tags                     = optional(map(string))
  }))
}
variable "o_rg_dtls" {
  description = "output resource group details"
  type = map(object({
    name     = string
    location = string
  }))
}
