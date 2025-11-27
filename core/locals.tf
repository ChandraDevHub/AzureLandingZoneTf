locals {
  # standard naming convention
  prefix = lower("${var.org}-${var.project}-${var.environment}")

  resource_group_name = "${local.prefix}-rg"
  vnet_name           = "${local.prefix}-vnet"
  storage_name        = "${replace(local.prefix, "-", "")}sa"
}
