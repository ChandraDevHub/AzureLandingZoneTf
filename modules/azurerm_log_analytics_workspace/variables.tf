variable "log_analytics_workspaces" {
  description = "Azure Log Analytics Workspace"
  type = map(object({
    name   = string
    rg_key = string
    # location          = string
    # rg_name           = string
    sku               = optional(string)
    retention_in_days = optional(number)

    tags = optional(map(string), {})
  }))
}
variable "o_rg_dtls" {
  description = "Resource Group output map"
  type = map(object({
    name     = string
    location = string
  }))
}
