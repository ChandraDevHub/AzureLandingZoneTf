
# AzureLandingZoneTf

This repository provides a modular, reusable Terraform implementation of an Azure Landing Zone. It contains Terraform modules for common Azure resources plus example environment configurations to help teams quickly provision a secure and repeatable foundation.

---

Overview
--------

The goal of this repository is to provide opinionated, reusable Terraform modules and example environments (`dev` and `prod`) so you can bootstrap an Azure Landing Zone with minimal configuration.

Key features
- Modular Terraform modules for common Azure resources (Resource Group, VNet, Subnet, NSG, VM, Key Vault, Storage, etc.)
- Example environment configurations under `environment/` for quick testing and deployment
- Clear variable interfaces and outputs per module

Repository layout
- `modules/` — Reusable Terraform modules (one folder per resource/module)
- `environment/` — Environment-specific configurations (`dev`, `prod`) containing example `main.tf`, `provider.tf`, `variables.tf`, and `terraform.tfvars`
- `README.md` — This document

Getting started (quick)
-----------------------

Prerequisites
- Terraform (recommended v1.0+). Download: https://www.terraform.io/downloads
- Azure CLI: `az login` to authenticate

Quick start
1. Change to the environment folder you want to deploy (example: `environment/dev`):

```powershell
cd .\environment\dev
terraform init
terraform validate
terraform plan -var-file="terraform.tfvars"
```

2. Apply the plan to create resources:

```powershell
terraform apply -var-file="terraform.tfvars"
```

If you plan to collaborate or run in CI, configure a remote backend (Azure Storage) in the environment `provider.tf` or in a `backend.tf` file.

Environments
- `environment/dev` — Example configuration for development and quick iterations
- `environment/prod` — Example configuration aimed at production; expects stricter variables and policies

Modules
-------
Each folder under `modules/` implements a single responsibility resource or a small set of related resources. Example modules include:
- `azurerm_linux_virtual_machine`
- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_network_security_group`
- `azurerm_public_ip`
- `azurerm_storage_account`
- `azurerm_key_vault` and supporting Key Vault modules
- `azurerm_log_analytics_workspace`

Inspect each module's `variables.tf` and `output.tf` for required inputs and outputs.

Variables and customization
---------------------------
- Use `terraform.tfvars` in each environment to set environment-specific values.
- Do not store secrets in plaintext in the repo. Use Azure Key Vault or a secure secrets backend for sensitive values.

Best practices
- Keep modules generic and idempotent so they can be reused across environments.
- Use a remote state backend (Azure Storage) for team collaboration and locking.
- Mark sensitive outputs and variables with `sensitive = true` where appropriate.
- Run `terraform fmt`, `terraform validate`, and optional linters like `tflint` before committing.

Testing and validation
- `terraform validate` — checks configuration syntax and module references
- `terraform plan` — reviews proposed changes
- Optional tools: `tflint`, `checkov`, or other IaC scanners for policy and security checks

Contributing
- Fork the repository and open a pull request with clear change descriptions.
- Follow existing module patterns and include examples/tests when adding new modules.

License
- Add an appropriate `LICENSE` file to the repository and update this section accordingly.

Next steps I can help with
- Add an example `backend.tf` for Azure Storage remote state
- Create a usage example for a module (minimal `main.tf` that calls `azurerm_linux_virtual_machine`)
- Add CI steps to run `terraform fmt` and `terraform validate`

---

If you want, I can now add an Azure Storage backend example to `environment/dev/provider.tf` or generate a small module usage example. Which should I do next?

