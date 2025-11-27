module "resource_groups" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "security_groups" {
  source          = "../../modules/azurerm_network_security_group"
  security_groups = var.security_groups
  o_rg_dtls       = module.resource_groups.o_rg_dtls
}

module "virtual_networks" {
  source           = "../../modules/azurerm_virtual_network"
  virtual_networks = var.virtual_networks
  o_rg_dtls        = module.resource_groups.o_rg_dtls
}
module "subnets" {
  source      = "../../modules/azurerm_subnet"
  subnets     = var.subnets
  o_rg_dtls   = module.resource_groups.o_rg_dtls
  o_vnet_dtls = module.virtual_networks.o_vnet_dtls
}
module "subnet_nsg_associations" {
  source                 = "../../modules/azurerm_subnet_network_security_group_association"
  subnet_nsg_association = var.subnet_nsg_association
  o_nsg_dtls             = module.security_groups.o_nsg_dtls
  o_subnet_dtls          = module.subnets.o_subnet_dtls
}
module "network_interfaces" {
  source             = "../../modules/azurerm_network_interface"
  network_interfaces = var.network_interfaces
  o_subnet_dtls      = module.subnets.o_subnet_dtls
}

module "public_ips" {
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
  o_rg_dtls  = module.resource_groups.o_rg_dtls
}

module "key_vaults" {
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
  o_rg_dtls  = module.resource_groups.o_rg_dtls
  tenant_id  = data.azurerm_client_config.current.tenant_id
  object_id  = data.azurerm_client_config.current.object_id
}
module "key_vault_secrets" {
  source            = "../../modules/azurerm_key_vault_secret"
  key_vault_secrets = var.key_vault_secrets
  o_keyvault_dtls   = module.key_vaults.o_keyvault_dtls
}
module "log_analytics_workspaces" {
  source                   = "../../modules/azurerm_log_analytics_workspace"
  log_analytics_workspaces = var.log_analytics_workspaces
  o_rg_dtls                = module.resource_groups.o_rg_dtls
}
module "bastion_hosts" {
  source           = "../../modules/azurerm_bastion_host"
  bastion_hosts    = var.bastion_hosts
  o_rg_dtls        = module.resource_groups.o_rg_dtls
  o_subnet_dtls    = module.subnets.o_subnet_dtls
  o_vnet_dtls      = module.virtual_networks.o_vnet_dtls
  o_public_ip_dtls = module.public_ips.o_public_ip_dtls
}
module "key_vault_keys" {
  source          = "../../modules/azurerm_key_vault_key"
  key_vault_keys  = var.key_vault_keys
  o_keyvault_dtls = module.key_vaults.o_keyvault_dtls
}
module "disk_encryption_sets" {
  source               = "../../modules/azurerm_disk_encryption_set"
  disk_encryption_sets = var.disk_encryption_sets
  o_rg_dtls            = module.resource_groups.o_rg_dtls
  o_keyvault_key_dtls  = module.key_vault_keys.o_keyvault_key_dtls
}
module "key_vault_access_policies_disk" {
  source                    = "../../modules/azurerm_key_vault_access_policy"
  key_vault_access_policies = var.key_vault_access_policies

  des_tenant_id = values(module.disk_encryption_sets.o_disk_encryption_set_dtls)[0].tenant_id
  des_object_id = values(module.disk_encryption_sets.o_disk_encryption_set_dtls)[0].principal_id

  o_keyvault_dtls = module.key_vaults.o_keyvault_dtls
}
module "key_vault_access_policies_user" {
  source                    = "../../modules/azurerm_key_vault_access_policy"
  key_vault_access_policies = var.key_vault_access_policies

  des_tenant_id = data.azurerm_client_config.current.tenant_id
  des_object_id = data.azurerm_client_config.current.object_id

  o_keyvault_dtls = module.key_vaults.o_keyvault_dtls
}
module "role_assignments" {
  source           = "../../modules/azurerm_role_assignment"
  role_assignments = var.role_assignments
  des_principal_id = values(module.disk_encryption_sets.o_disk_encryption_set_dtls)[0].principal_id
  o_keyvault_dtls  = module.key_vaults.o_keyvault_dtls
}
module "firewalls" {
  source           = "../../modules/azurerm_azure_firewall"
  firewalls        = var.firewalls
  o_public_ip_dtls = module.public_ips.o_public_ip_dtls
  o_rg_dtls        = module.resource_groups.o_rg_dtls
  o_subnet_dtls    = module.subnets.o_subnet_dtls
}
module "route_tables" {
  source       = "../../modules/azurerm_route_table"
  route_tables = var.route_tables
  o_rg_dtls    = module.resource_groups.o_rg_dtls
}
module "routes" {
  source             = "../../modules/azurerm_route"
  nw_routes          = var.nw_routes
  o_rg_dtls          = module.resource_groups.o_rg_dtls
  o_route_table_dtls = module.route_tables.o_route_table_dtls
  o_firewall_dtls    = module.firewalls.o_firewall_dtls
}
module "subnet_rt_assocs" {
  source             = "../../modules/azurerm_subnet_route_table_association"
  subnet_rt_assocs   = var.subnet_rt_assocs
  o_route_table_dtls = module.route_tables.o_route_table_dtls
  o_subnet_dtls      = module.subnets.o_subnet_dtls
}
module "storage_accounts" {
  source           = "../../modules/azurerm_storage_account"
  storage_accounts = var.storage_accounts
  o_rg_dtls        = module.resource_groups.o_rg_dtls
}
module "managed_disks" {
  source        = "../../modules/azurerm_managed_disk"
  managed_disks = var.managed_disks
  o_rg_dtls     = module.resource_groups.o_rg_dtls
}
module "linux_virtual_machines" {
  source                  = "../../modules/azurerm_linux_virtual_machine"
  linux_virtual_machines  = var.linux_virtual_machines
  o_rg_dtls               = module.resource_groups.o_rg_dtls
  o_nic_dtls              = module.network_interfaces.o_nic_dtls
  o_key_vault_secret_dtls = module.key_vault_secrets.o_key_vault_secret_dtls
}
