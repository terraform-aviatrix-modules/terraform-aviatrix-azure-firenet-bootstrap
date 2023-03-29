module "azure_paloalto" {
  count  = local.firewall_vendor == "paloalto" ? 1 : 0
  source = "./modules/azure_paloalto"

  region = var.region
}

module "azure_checkpoint" {
  count  = local.firewall_vendor == "checkpoint" ? 1 : 0
  source = "./modules/azure_checkpoint"
}

module "azure_fortigate" {
  count  = local.firewall_vendor == "fortigate" ? 1 : 0
  source = "./modules/azure_fortigate"

  hostname     = var.hostname
  password     = var.password
  internal_gw  = var.internal_gw
  admintimeout = var.admintimeout
}
