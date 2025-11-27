data "azurerm_client_config" "current" {}

data "azurerm_key_vault_secret" "vm_username" {
  for_each = var.key_vault_secrets

  name         = "vm-username"
  key_vault_id = module.key_vaults.o_keyvault_dtls[each.value.kv_key].id
}
data "azurerm_key_vault_secret" "vm_password" {
  for_each = var.key_vault_secrets

  name         = "vm-password"
  key_vault_id = module.key_vaults.o_keyvault_dtls[each.value.kv_key].id
}