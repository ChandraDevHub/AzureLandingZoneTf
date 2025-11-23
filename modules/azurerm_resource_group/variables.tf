variable "resource_groups" {
  description = "resource groups"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
}
