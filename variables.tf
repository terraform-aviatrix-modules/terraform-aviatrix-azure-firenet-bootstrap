variable "cloud" {
  description = "Cloud type"
  type        = string

  validation {
    condition     = contains(["aws", "azure"], lower(var.cloud)) #Only AWS+Azure support for now
    error_message = "Invalid cloud type. Choose AWS or Azure."
  }
}

variable "use_default_bootstrap" {
  description = "By default, the module will use prepacked bootstrap files."
  type        = bool
  default     = true
}

variable "firewall_vendor" {
  description = "Name of the firewall vendor"
  type        = string

  validation {
    condition     = contains(["fortigate", "checkpoint", "paloalto"], lower(var.firewall_vendor))
    error_message = "Invalid vendor. Choose Checkpoint, Fortigate or PaloAlto."
  }
}

locals {
  cloud           = lower(var.cloud)
  firewall_vendor = lower(var.firewall_vendor)

  user_data = lookup(local.user_data_map, local.cloud, "")
  user_data_map = {
    azure = local.cloud == "azure" ? local.user_data_vendor_aws : null,
    aws   = local.cloud == "aws" ? local.user_data_vendor_azure : null,
  }

  user_data_vendor_aws = lookup(local.user_data_vendor_aws_map, local.firewall_vendor, "")
  user_data_vendor_aws_map = {
    checkpoint = local.firewall_vendor == "checkpoint" && local.cloud == "aws" ? module.aws_checkpoint[0].user_data : null,
    fortigate  = local.firewall_vendor == "fortigate"  && local.cloud == "aws" ? module.aws_fortigate[0].user_data : null,
  }

  user_data_vendor_azure = lookup(local.user_data_vendor_azure_map, local.firewall_vendor, "")
  user_data_vendor_azure_map = {
    checkpoint = local.firewall_vendor == "checkpoint" && local.cloud == "azure" ? module.azure_checkpoint[0].user_data : null,
    fortigate  = local.firewall_vendor == "fortigate" && local.cloud == "azure" ? module.azure_fortigate[0].user_data : null,
  }
}

