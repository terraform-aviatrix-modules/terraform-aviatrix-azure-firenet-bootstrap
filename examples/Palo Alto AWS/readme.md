```
module "bootstrap" {
  source  = "terraform-aviatrix-modules/mc-firenet-bootstrap/aviatrix"
  version = "1.0.0"
  
  cloud           = "aws"
  firewall_vendor = "paloalto"
}

module "transit_firenet_1" {
  source  = "terraform-aviatrix-modules/aws-transit-firenet/aviatrix"
  version = "4.0.3"

  cidr                    = "10.1.0.0/20"
  region                  = "eu-west-1"
  account                 = "AWS"
  firewall_image          = "Palo Alto Networks VM-Series Next-Generation Firewall Bundle 1"
  iam_role_1              = module.bootstrap.iam_role
  bootstrap_bucket_name_1 = module.bootstrap.bootstrap_bucket_name
}
```