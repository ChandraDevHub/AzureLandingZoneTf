output "o_rg_dtls" {
  description = "Map of resource group names and locations"
  value = {
    for rg_key, rg in azurerm_resource_group.resource_groups :
    rg_key => {
      name     = rg.name
      location = rg.location
    }
  }
}