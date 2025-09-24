##################################################################################################
# EL10 (Alma 10) Static IP Configuration
##################################################################################################

# Find the currently applied IP

hostname -I | cut -d' ' -f1

# Find the gateway IP address

ip r | awk '/^def/{print $3}'

# Configure the network to manual and set the IP as static

nmcli con modify '{interface name}' ifname {interface name} ipv4.method manual ipv4.addresses {requested ip} gw4 {gateway ip}

nmcli con modify '{interface name}' ipv4.dns 4.2.2.2

nmcli con down '{interface name}'

nmcli con up '{interface name}'
