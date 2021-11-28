```
module "bootstrap" {
  source  = "terraform-aviatrix-modules/mc-firenet-bootstrap/aviatrix"
  version = "1.0.0"
  
  cloud           = "azure"
  firewall_vendor = "paloalto"
  region          = "West Europe"
}

module "transit_firenet_1" {
  source  = "terraform-aviatrix-modules/azure-transit-firenet/aviatrix"
  version = "4.0.3"

  cidr                     = "10.1.0.0/20"
  region                   = "West Europe"
  account                  = "Azure"
  firewall_image           = "Palo Alto Networks VM-Series Next-Generation Firewall Bundle 1"
  bootstrap_storage_name_1 = module.bootstrap.bootstrap_storage_name
  storage_access_key_1     = module.bootstrap.storage_access_key
  file_share_folder_1      = module.bootstrap.file_share_folder
}
```