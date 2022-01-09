# terraform-aviatrix-mc-firenet-bootstrap

### Description
Module to easily create infrastructure to bootstrap Firenet NGFW instances

### Diagram
\<Provide a diagram of the high level constructs thet will be created by this module>
<img src="<IMG URL>"  height="250">

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.0.0 | 0.13-v1.x | >=6.4 | >=2.19.0

### Usage Example
```
module "bootstrap_fw1" {
  source  = "terraform-aviatrix-modules/mc-firenet-bootstrap/aviatrix"
  version = "1.0.0"


}
```

### Variables
The following variables are required:

key | value
:--- | :---
\<keyname> | \<description of value that should be provided in this variable>

The following variables are optional:

key | default | value 
:---|:---|:---
\<keyname> | \<default value> | \<description of value that should be provided in this variable>

### Outputs
This module will return the following outputs:

key | description
:---|:---
user_data | Generated user_data in case of Checkpoint or FortiGate firewall.

For the Palo Alto instances, the default username and password are:
AWS User account: admin/Aviatrix123# API Account: avxadmin/Aviatrix123#