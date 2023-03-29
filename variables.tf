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

variable "region" {
  type        = string
  description = "Region in which to create the storage account."
  default     = null
}

variable "password" {
  type        = string
  description = "Password to be configured for the firewall."
  default     = "Aviatrix#1234"
}

variable "hostname" {
  type        = string
  description = "Hostname to be set on the firewall"
  default     = "hostname"
}

variable "internal_gw" {
  type        = string
  description = "IP of the VNET router (first IP), for configuring internal routing"
  default     = ""
}

locals {
  firewall_vendor = lower(var.firewall_vendor)

  user_data = lookup(local.user_data_vendor_map, local.firewall_vendor, "")
  user_data_vendor_map = {
    checkpoint = local.firewall_vendor == "checkpoint" ? module.azure_checkpoint[0].user_data : null,
    fortigate  = local.firewall_vendor == "fortigate" ? module.azure_fortigate[0].user_data : null,
  }

  bootstrap_storage_name = local.firewall_vendor == "paloalto" ? module.azure_paloalto[0].bootstrap_storage_name : null
  storage_access_key     = local.firewall_vendor == "paloalto" ? module.azure_paloalto[0].storage_access_key : null
  file_share_folder      = local.firewall_vendor == "paloalto" ? module.azure_paloalto[0].file_share_folder : null
}

