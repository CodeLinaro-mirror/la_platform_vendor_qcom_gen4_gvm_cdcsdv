#!/vendor/bin/sh
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#
# Vendor-side wrapper for create_vlan_vm_1.sh
# Uses /vendor/bin/sh shebang so it runs entirely in vendor domain
# without needing system_file execute permissions.

echo "$0 start." > /dev/kmsg

# disable ARP
/system/bin/ip link set dev eth0 arp off
/system/bin/ip link set eth0 up
/system/bin/ip addr add 192.168.1.2/24 broadcast 192.168.1.255 dev eth0

/system/bin/ip rule add from all lookup main

# VLAN interface creation
/system/bin/ip link add link eth0 name eth0.110 type vlan id 110
/system/bin/ip link set dev eth0.110 arp off
/system/bin/ip link set eth0.110 type vlan egress 0:1
/system/bin/ip link set eth0.110 up
/system/bin/ip addr add 192.168.11.1/24 broadcast 192.168.11.255 dev eth0.110

/system/bin/ip link add link eth0 name eth0.1100 type vlan id 1100
/system/bin/ip link set dev eth0.1100 arp off
/system/bin/ip link set eth0.1100 type vlan egress 0:1
/system/bin/ip link set eth0.1100 up
/system/bin/ip addr add 192.168.74.1/24 broadcast 192.168.74.255 dev eth0.1100

/system/bin/ip link add link eth0 name eth0.1400 type vlan id 1400
/system/bin/ip link set dev eth0.1400 arp off
/system/bin/ip link set eth0.1400 type vlan egress 0:4
/system/bin/ip link set eth0.1400 up
/system/bin/ip addr add 192.168.104.1/24 broadcast 192.168.104.255 dev eth0.1400

/system/bin/ip link add link eth0 name eth0.1500 type vlan id 1500
/system/bin/ip link set dev eth0.1500 arp off
/system/bin/ip link set eth0.1500 type vlan egress 0:5
/system/bin/ip link set eth0.1500 up
/system/bin/ip addr add 192.168.114.1/24 broadcast 192.168.114.255 dev eth0.1500

/system/bin/ip link add link eth0 name eth0.1510 type vlan id 1510
/system/bin/ip link set dev eth0.1510 arp off
/system/bin/ip link set eth0.1510 type vlan egress 0:5
/system/bin/ip link set eth0.1510 up
/system/bin/ip addr add 192.168.115.1/24 broadcast 192.168.115.255 dev eth0.1510

/system/bin/ip link add link eth0 name eth0.2110 type vlan id 2110
/system/bin/ip link set dev eth0.2110 arp off
/system/bin/ip link set eth0.2110 type vlan egress 0:1
/system/bin/ip link set eth0.2110 up
/system/bin/ip addr add 192.168.139.1/24 broadcast 192.168.139.255 dev eth0.2110

/system/bin/ip link add link eth0 name eth0.2120 type vlan id 2120
/system/bin/ip link set dev eth0.2120 arp off
/system/bin/ip link set eth0.2120 type vlan egress 0:1
/system/bin/ip link set eth0.2120 up
/system/bin/ip addr add 192.168.140.1/24 broadcast 192.168.140.255 dev eth0.2120

# Static ARP config
/system/bin/ip neigh replace 192.168.139.99 lladdr AA:BB:CC:DD:30:60 dev eth0.2110
/system/bin/ip neigh replace 192.168.11.10 lladdr  AA:BB:CC:DD:00:0A dev eth0.110
/system/bin/ip neigh replace 192.168.11.96 lladdr AA:BB:CC:DD:00:60 dev eth0.110
/system/bin/ip neigh replace 192.168.74.42 lladdr AA:BB:CC:DD:00:2A dev eth0.1100
/system/bin/ip neigh replace 192.168.74.99 lladdr AA:BB:CC:DD:30:60 dev eth0.1100
/system/bin/ip neigh replace 192.168.74.98 lladdr AA:BB:CC:DD:20:60 dev eth0.1100
/system/bin/ip neigh replace 192.168.115.42 lladdr AA:BB:CC:DD:00:2A dev eth0.1510
/system/bin/ip neigh replace 192.168.140.110 lladdr AA:BB:CC:DD:10:0A dev eth0.2120
/system/bin/ip neigh replace 192.168.140.56 lladdr AA:BB:CC:DD:00:38 dev eth0.2120
/system/bin/ip neigh replace 192.168.114.42 lladdr AA:BB:CC:DD:00:2A dev eth0.1500
/system/bin/ip neigh replace 192.168.114.3 lladdr AA:BB:CC:DD:00:03 dev eth0.1500
/system/bin/ip neigh replace 192.168.74.81 lladdr AA:BB:CC:DD:20:60 dev eth0.1100
/system/bin/ip neigh replace 192.168.74.50 lladdr AA:BB:CC:DD:20:60 dev eth0.1100
/system/bin/ip neigh replace 192.168.74.96 lladdr AA:BB:CC:DD:20:60 dev eth0.1100
/system/bin/ip neigh replace 192.168.114.57 lladdr AA:BB:CC:DD:20:60 dev eth0.1500
/system/bin/ip neigh replace 192.168.114.80 lladdr AA:BB:CC:DD:20:60 dev eth0.1500
/system/bin/ip neigh replace 192.168.114.58 lladdr AA:BB:CC:DD:20:60 dev eth0.1500
/system/bin/ip neigh replace 192.168.114.100 lladdr AA:BB:CC:DD:20:60 dev eth0.1500
/system/bin/ip neigh replace 192.168.114.59 lladdr AA:BB:CC:DD:20:60 dev eth0.1500
/system/bin/ip neigh replace 192.168.104.2 lladdr AA:BB:CC:DD:00:02 dev eth0.1400
/system/bin/ip neigh replace 192.168.104.99 lladdr AA:BB:CC:DD:30:60 dev eth0.1400
/system/bin/ip neigh replace 192.168.168.81 lladdr AA:BB:CC:DD:20:60 dev eth0.1400
/system/bin/ip neigh replace 192.168.168.96 lladdr AA:BB:CC:DD:20:60 dev eth0.1400
/system/bin/ip neigh replace 237.50.20.1 lladdr 01:00:5E:32:14:01 dev eth0.1500
/system/bin/ip neigh replace 237.50.25.1 lladdr 01:00:5E:32:19:01 dev eth0.1500
/system/bin/ip neigh replace 237.51.0.1 lladdr 01:00:5E:33:00:01 dev eth0.1510

# Route Table for Multicast Packets
/system/bin/ip route add 237.50.20.1 dev eth0.1500
/system/bin/ip route add 237.50.25.1 dev eth0.1500
/system/bin/ip route add 237.51.0.1 dev eth0.1510

# Route Table for PCU_DMZ_BACK and PCU_MAIN
/system/bin/ip route add 192.168.168.96 dev eth0.1400
/system/bin/ip route add 192.168.168.81 dev eth0.1400

echo "$0 done." > /dev/kmsg
