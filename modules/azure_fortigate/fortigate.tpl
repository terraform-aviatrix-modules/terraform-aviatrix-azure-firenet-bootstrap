config system admin
    edit admin
        set password ${password}
end
config system global
    set hostname ${hostname}
    set admintimeout ${admintimeout}
end

# Important HTTPS needs to be allowed on LAN interface for Firewall Health Check
config system interface
    edit port2
        set allowaccess https
    next
end

#RFC 1918 Routes and Subnet Default Gateway
config router static
    edit 1
        set dst 10.0.0.0 255.0.0.0
        set gateway ${internal_gw}
        set device port2
    next
    edit 2
        set dst 192.168.0.0 255.255.0.0
        set gateway ${internal_gw}
        set device port2
    next
    edit 3
        set dst 172.16.0.0 255.240.0.0
        set gateway ${internal_gw}
        set device port2
    next
    # LoadBalancer IP
    edit 4
        set dst 168.63.129.16 255.255.255.255
        set gateway ${internal_gw}
        set device port2
    next
end

# Firewall Allow All Policy Example
config firewall policy
    edit 1
        set name allow_all
        set srcintf port2
        set dstintf port2
        set srcaddr all
        set dstaddr all
        set action accept
        set schedule always
        set service ALL
    next
    edit 2
        set name allow_all_internet
        set srcintf port2
        set dstintf port1
        set srcaddr all
        set dstaddr all
        set action accept
        set schedule always
        set service ALL
        set nat enable
    next    
end