# terraform-aviatrix-azure-firenet-bootstrap

### Description
Module to easily create infrastructure to bootstrap Firenet NGFW instances in Azure.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | >=v1.0 | >=6.4 | >=3.0.0

### Usage Example
```
module "bootstrap_fw1" {
  source  = "terraform-aviatrix-modules/azurre-firenet-bootstrap/aviatrix"
  version = "1.0.0"


}
```

### FortiGate Variables
The following variables are required:

key | value
:--- | :---
firewall_vendor | Set to "Fortigate".

The following variables are optional:

key | default | value 
:---|:---|:---
password | Aviatrix#1234 | Password to log in to the Firewall

### Palo Alto Variables
The following variables are required:

key | value
:--- | :---
firewall_vendor | Set to "Palo Alto".

The following variables are optional:

key | default | value 
:---|:---|:---

### Checkpoint Variables
The following variables are required:

key | value
:--- | :---
firewall_vendor | Set to "Checkpoint".

The following variables are optional:

key | default | value 
:---|:---|:---
password | Aviatrix#1234 | Password in case of Fortigate or Checkpoint firewall.

### Outputs
This module will return the following outputs:

key | description
:---|:---
user_data | Generated user_data in case of Checkpoint or FortiGate firewall.

For the Palo Alto instances, the default username and password are:
AWS User account: admin/Aviatrix123# API Account: avxadmin/Aviatrix123#