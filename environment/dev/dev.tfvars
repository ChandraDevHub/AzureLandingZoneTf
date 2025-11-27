# metadata
org           = "contoso"
project       = "erp"
environment   = "dev"

# azure
subscription_id = "10faea19-035c-4025-9136-201ca3e88e6d"
tenant_id       = "d8f47671-2a52-4a2e-badb-9fb565a090c1"

# core infra variables
resource_groups = {
  dev_rg1 = {
    name       = "dev_rg_it"
    location   = "eastus"
    managed_by = "it_team"
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
  dev_rg2 = {
    name       = "dev_rg_finance"
    location   = "westus"
    managed_by = "finance_team"
    tags = {
      environment = "dev"
      department  = "finance"
    }
  }
}
security_groups = {
  "dev_nsg1" = {
    name   = "dev_nsg_it"
    rg_key = "dev_rg1"
    # location = "eastus"
    # rg_name  = "dev_rg_it"
    tags = {
      environment = "dev"
      department  = "it"
    }
    security_rules = [
      {
        name                       = "Allow_HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow_HTTPS"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow_SSH"
        priority                   = 111
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}
virtual_networks = {
  "dev_vnet1" = {
    name   = "dev_vnet_it"
    rg_key = "dev_rg1"
    # location            = "eastus"
    # resource_group_name = "dev_rg_it"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["8.8.8.8", "8.8.4.4"]
    # subnets = {
    #   frontend = {
    #     name             = "dev_subnet_frontend"
    #     address_prefixes = ["10.0.1.0/24"]
    #   }
    #   backend = {
    #     name             = "dev_subnet_backend"
    #     address_prefixes = ["10.0.2.0/24"]
    #   }
    # }
  }
}
subnets = {
  frontend = {
    name             = "dev_subnet_frontend"
    address_prefixes = ["10.0.1.0/24"]
    rg_key           = "dev_rg1"
    vnet_key         = "dev_vnet1"
  }
  backend = {
    name             = "dev_subnet_backend"
    address_prefixes = ["10.0.2.0/24"]
    rg_key           = "dev_rg1"
    vnet_key         = "dev_vnet1"
  }
  AzureBastionSubnet = {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.0.3.0/24"]
    rg_key           = "dev_rg1"
    vnet_key         = "dev_vnet1"
  }
  AzureFirewallSubnet = {
    name             = "AzureFirewallSubnet"
    address_prefixes = ["10.0.4.0/24"]
    rg_key           = "dev_rg1"
    vnet_key         = "dev_vnet1"
  }
}
subnet_nsg_association = {
  frontend_assoc = {
    subnet_key = "frontend"
    nsg_key    = "dev_nsg1"
  }
  backend_assoc = {
    subnet_key = "backend"
    nsg_key    = "dev_nsg1"
  }
}
network_interfaces = {
  nic1 = {
    name       = "dev_nic_frontend"
    location   = "eastus"
    rg_name    = "dev_rg_it"
    subnet_key = "frontend"

    ip_configuration = {
      name                          = "ipconfig1"
      private_ip_address_allocation = "Dynamic"
    }
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
  nic2 = {
    name       = "dev_nic_backend"
    location   = "eastus"
    rg_name    = "dev_rg_it"
    subnet_key = "backend"

    ip_configuration = {
      name                          = "ipconfig1"
      private_ip_address_allocation = "Dynamic"
    }
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
}
public_ips = {
  "pip_bastion" = {
    name              = "dev_public_ip_bastion"
    rg_key            = "dev_rg1"
    allocation_method = "Static"
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
  "pip_firewall" = {
    name              = "dev_public_ip_firewall"
    rg_key            = "dev_rg1"
    allocation_method = "Static"
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
}
key_vaults = {
  "dev_kv" = {
    kv_name = "devkeyvaultit"
    rg_key  = "dev_rg1"

    enabled_for_disk_encryption = true
    # tenant_id                   = "your-tenant-id"
    soft_delete_retention_days = 7
    purge_protection_enabled   = false
    sku_name                   = "standard"

    tags = {
      environment = "dev"
      department  = "it"
    }

    access_policies = [
      {
        # tenant_id           = "your-tenant-id"
        # object_id           = "your-object-id"
        key_permissions = [
          "Get",
        ]
        secret_permissions = [
          "Backup",
          "Delete",
          "Get",
          "List",
          "Purge",
          "Recover",
          "Restore",
          "Set"
        ]
        storage_permissions = [
          "Get",
        ]
      }
    ]
  }
  dev_des_keyvault = { #disk encryption set
    kv_name = "devkeyvaultdes"
    rg_key  = "dev_rg1"

    enabled_for_disk_encryption = true
    # tenant_id                   = "your-tenant-id"
    enabled_for_disk_encryption = true
    purge_protection_enabled    = true
    soft_delete_retention_days  = 7
    sku_name                    = "standard"
  }
}

key_vault_secrets = {
  "dev_kv_secrets_u_name" = {
    secret_name = "vm-username"
    value       = "devopsadmin"
    kv_key      = "dev_kv"
  }
  "dev_kv_secrets_u_password" = {
    secret_name = "vm-password"
    value       = "P@ssw0rd1234!"
    kv_key      = "dev_kv"
  }
}
log_analytics_workspaces = {
  "dev_law" = {
    name   = "dev-law-it"
    rg_key = "dev_rg1"
    # location          = "eastus"
    # rg_name           = "dev_rg_it"
    sku               = "PerGB2018"
    retention_in_days = 30
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
}
bastion_hosts = {
  "dev_bastion" = {
    name     = "dev-bastion-it"
    rg_key   = "dev_rg1"
    vnet_key = "dev_vnet1"
    sku      = "Standard"
    tags = {
      environment = "dev"
      department  = "it"
    }
    ip_configuration = {
      name          = "bastion-ip-config"
      subnet_key    = "AzureBastionSubnet"
      public_ip_key = "pip_bastion"
    }
  }
}
key_vault_keys = {
  "dev_kv_keys" = {
    name     = "des-key" #des=disk encryption set
    kv_key   = "dev_des_keyvault"
    key_type = "RSA"
    key_size = 2048
    key_opts = [
      "decrypt",
      "encrypt",
      "sign",
      "unwrapKey",
      "verify",
      "wrapKey",
    ]
  }
}
disk_encryption_sets = {
  "dev_des" = {
    name          = "des"
    rg_key        = "dev_rg1"
    kv_key_key    = "dev_kv_keys"
    identity_type = "SystemAssigned"
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
}
key_vault_access_policies = {
  "dev_kvap" = {
    kv_key = "dev_des_keyvault"
    key_permissions = [
      "Create",
      "Delete",
      "Get",
      "Purge",
      "Recover",
      "Update",
      "List",
      "Decrypt",
      "Sign",
      "GetRotationPolicy",
    ]
  }
}
role_assignments = {
  "dev_ra_disk" = {
    kv_key               = "dev_des_keyvault"
    role_definition_name = "Key Vault Crypto Service Encryption User"
  }
}
firewalls = {
  "dev_fw" = {
    name     = "dev_firewall_it"
    rg_key   = "dev_rg1"
    sku_name = "AZFW_VNet"
    sku_tier = "Standard"
    ip_configuration = {
      name          = "fw-ip-config"
      subnet_key    = "AzureFirewallSubnet"
      public_ip_key = "pip_firewall"
    }
  }
}
route_tables = {
  "dev_rt" = {
    name   = "dev_route_table_it"
    rg_key = "dev_rg1"
  }
}
nw_routes = {
  "dev_r_it" = {
    name           = "dev_route_it"
    rg_key         = "dev_rg1"
    firewall_key   = "dev_fw"
    rt_key         = "dev_rt"
    next_hop_type  = "VirtualAppliance"
    address_prefix = "0.0.0.0/0"
  }
}
subnet_rt_assocs = {
  "dev_subnet_rt_assoc" = {
    subnet_key = "AzureFirewallSubnet"
    rt_key     = "dev_rt"
  }
}
storage_accounts = {
  "dev_stg" = {
    name                     = "devstgitstorage"
    rg_key                   = "dev_rg1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
}
managed_disks = {
  "dev_md" = {
    name                 = "dev_managed_disk_it"
    rg_key               = "dev_rg1"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 1
    create_option        = "Empty"
    tags = {
      environment = "dev"
      department  = "it"
    }
  }
}
linux_virtual_machines = {
  "dev_vm1" = {
    name           = "dev_vm_it_1"
    rg_key         = "dev_rg1"
    nic_keys        = ["nic1", "nic2"]
    vm_size        = "Standard_L2aos_v4"
    username_secret_key = "dev_kv_secrets_u_name"
    password_secret_key = "dev_kv_secrets_u_password"
    disable_password_authentication = false
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    tags = {
      environment = "dev"
      department  = "it"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
}
