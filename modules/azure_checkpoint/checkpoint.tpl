#!/bin/bash

clish -c "set user admin password ${password} -s
clish -c 'set interface eth1 state on' -s
clish -c 'set hostname ${hostname}' -s
blink_config -s 'upload_info=false&download_info=false&install_security_gw=true&install_ppak=true&install_security_managment=false&ipstat_v6=off&ftw_sic_key=${sic_key}'
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin forced-commands-only/PermitRootLogin yes/' /etc/ssh/sshd_config
service sshd reload