###############################
#   Organization Metadata
###############################

variable "org" {
  description = "Organization or company short code (e.g., contoso, msft)"
  type        = string
}

variable "project" {
  description = "Project/application name (e.g., erp, billing, portal)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, test, prod)"
  type        = string
}



###############################
#   Azure Authentication
###############################

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}



###############################
#   Core Infra Variables
###############################

variable "resource_groups" {
  description = "resource groups"
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}
variable "security_groups" {
  description = "Network Security Groups"
  type = map(object({
    name   = string
    rg_key = string
    # location = string
    # rg_name  = string
    tags = optional(map(string))
    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
    })), [])
  }))
}
variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    name   = string
    rg_key = string
    # location            = string
    # resource_group_name = string
    address_space = list(string)
    dns_servers   = optional(list(string), [])
    # subnets = map(object({
    #   name             = string
    #   address_prefixes = list(string)
    # }))
    tags = optional(map(string), {})
  }))
}
variable "subnets" {
  description = "Subnets for Azure Resources"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    rg_key           = string
    vnet_key         = string
  }))
}
variable "subnet_nsg_association" {
  description = "subnet and network security group association"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}
variable "network_interfaces" {
  description = "Network Interfaces"
  type = map(object({
    name       = string
    location   = string
    rg_name    = string
    subnet_key = string

    ip_configuration = object({
      name                          = string
      private_ip_address_allocation = string
    })

    tags = optional(map(string), {})
  }))
}

variable "public_ips" {
  description = "Public IPs of the azure resources"
  type = map(object({
    name              = string
    rg_key            = string
    allocation_method = string
    tags              = optional(map(string), {})
  }))
}
variable "key_vaults" {
  description = "Map of Key Vaults"
  type = map(object({
    kv_name = string
    rg_key  = string #rg_name aur location ke liye hai
    # location       = string
    # rg_name        = string
    enabled_for_disk_encryption = bool
    # tenant_id                   = string
    soft_delete_retention_days = number
    purge_protection_enabled   = bool

    sku_name = string

    tags = optional(map(string), {})

    # Access policies (optional, but recommended to make it dynamic)
    access_policies = optional(list(object({
      # tenant_id           = string
      # object_id           = string
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    })), [])
  }))
}
variable "key_vault_secrets" {
  description = "Azure Key Vault Secrets"
  type = map(object({
    secret_name = string #KV_Key
    value       = string
    kv_key      = string
  }))
}
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
variable "bastion_hosts" {
  description = "Bastion Host"
  type = map(object({
    name = string
    # location   = string
    rg_key   = string
    vnet_key = string
    sku      = string
    tags     = optional(map(string), {})
    ip_configuration = object({
      name          = string
      subnet_key    = string
      public_ip_key = string
    })
  }))
}
variable "key_vault_keys" {
  description = "Map of Key Vault Keys to create"
  type = map(object({
    name     = string
    kv_key   = string           # Key Vault reference key
    key_type = string           # e.g., RSA, RSA-HSM, EC
    key_size = optional(number) # only for RSA keys
    key_opts = list(string)     # operations allowed
  }))
}
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
variable "key_vault_access_policies" {
  description = "Key vault access policies"
  type = map(object({
    kv_key          = string
    key_permissions = list(string)
  }))
}
variable "role_assignments" {
  description = "Role assignments"
  type = map(object({
    kv_key               = string
    role_definition_name = string
  }))
}
variable "firewalls" {
  description = "Azure firewall for my subnet"
  type = map(object({
    name     = string
    rg_key   = string
    sku_name = string
    sku_tier = string

    ip_configuration = object({
      name          = string
      subnet_key    = string
      public_ip_key = string
    })
  }))
}
variable "route_tables" {
  description = "route table"
  type = map(object({
    name   = string
    rg_key = string
  }))
}
variable "nw_routes" {
  description = "route"
  type = map(object({
    name           = string
    rg_key         = string
    firewall_key   = string
    rt_key         = string
    next_hop_type  = string
    address_prefix = string
  }))
}
variable "subnet_rt_assocs" {
  description = "subnet route table associations"
  type = map(object({
    subnet_key = string
    rt_key     = string
  }))
}
variable "storage_accounts" {
  description = "storage accounts"
  type = map(object({
    name                     = string
    rg_key                   = string
    account_tier             = string
    account_replication_type = string
    tags                     = optional(map(string))
  }))
}
variable "managed_disks" {
  description = "managed disks"
  type = map(object({
    name                 = string
    rg_key               = string
    storage_account_type = string
    disk_size_gb         = number
    create_option        = string
    tags                 = optional(map(string))
  }))
}
variable "linux_virtual_machines" {
  description = "Linux Virtual Machine"
  type = map(object({
    name           = string
    rg_key         = string
    nic_keys       = list(string)
    vm_size        = string
    username_secret_key = string
    password_secret_key = string
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
