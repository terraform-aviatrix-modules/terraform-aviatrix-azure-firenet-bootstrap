config system admin
    edit admin
        set password ${password}
end
config system global
    set hostname ${hostname}
end
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
end
