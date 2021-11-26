module "aws_paloalto" {
  count  = local.cloud == "aws" ? (local.firewall_vendor == "paloalto" ? 1 : 0) : 0
  source = "./modules/aws_paloalto"
}

module "azure_paloalto" {
  count  = local.cloud == "azure" ? (local.firewall_vendor == "paloalto" ? 1 : 0) : 0
  source = "./modules/azure_paloalto"

  region = ""
}

module "aws_checkpoint" {
  count  = local.cloud == "aws" ? (local.firewall_vendor == "checkpoint" ? 1 : 0) : 0
  source = "./modules/aws_checkpoint"
}

module "azure_checkpoint" {
  count  = local.cloud == "azure" ? (local.firewall_vendor == "checkpoint" ? 1 : 0) : 0
  source = "./modules/azure_checkpoint"
}

module "aws_fortigate" {
  count  = local.cloud == "aws" ? (local.firewall_vendor == "fortigate" ? 1 : 0) : 0
  source = "./modules/aws_fortigate"
}

module "azure_fortigate" {
  count  = local.cloud == "azure" ? (local.firewall_vendor == "fortigate" ? 1 : 0) : 0
  source = "./modules/azure_fortigate"
}