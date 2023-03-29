variable "password" {
  type        = string
  description = "Password to be configured for the FortiGate firewall"
}

variable "hostname" {
  type        = string
  description = "Hostname to be set on the FortiGate"
}

variable "internal_gw" {
  type        = string
  description = "IP of the VNET router (first IP), for configuring internal routing on the FortiGate"
}

variable "admintimeout" {
  type        = number
  description = "Timeout for admin web UI"
  default     = 60
}
