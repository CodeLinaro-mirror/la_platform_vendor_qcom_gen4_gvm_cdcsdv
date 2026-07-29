#!/vendor/bin/sh
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#
# Vendor-side wrapper: identical to commonsys version but reads
# whitelist_rbvm.csv from /vendor/bin/ instead of /system_ext/bin/.

echo "$0 start iptables script." > /dev/kmsg

# input file path — vendor partition
input_file="/vendor/bin/whitelist_rbvm.csv"

if [ ! -f "$input_file" ]; then
  echo "Error: Input file '$input_file' not found." > /dev/kmsg
  exit 1
fi

# Switch Information
ingress_port=""
egress_port=""

# IPv4 header
version=""
protocol=""
source_ip=""
dest_ip=""
source_port=""
dest_port=""

# linux ephemeral port ranges
ephemeral_start_port=32768
ephemeral_end_port=65535

############################### iptables rules ###############################
drop_rules()
{
    echo "dropping all incoming traffic by default"
    /system/bin/iptables -P INPUT DROP
    /system/bin/iptables -P OUTPUT DROP
}

loopback_rules()
{
    echo "allow loopback"
    /system/bin/iptables -I INPUT -i lo -j ACCEPT
    /system/bin/iptables -I OUTPUT -o lo  -j ACCEPT
}

install_iptable_rule()
{
    local chain_type="${1}"
    local iptable_cmd="-A ${chain_type}"

    if [ -n "$protocol" ] && [ "$protocol" != '$' ]; then
        case "$protocol" in
            "1.0") iptable_cmd="$iptable_cmd -p icmp" ;;
            "2.0") iptable_cmd="$iptable_cmd -p igmp" ;;
            "6.0") iptable_cmd="$iptable_cmd -p tcp" ;;
            "17.0") iptable_cmd="$iptable_cmd -p udp" ;;
            *) iptable_cmd="$iptable_cmd -p ${protocol}" ;;
        esac
    fi

    if [ "$source_port" = "Ephemeral" ]; then
        iptable_cmd="$iptable_cmd --sport ${ephemeral_start_port}:${ephemeral_end_port}"
    elif [ -n "$source_port" ] && [ "$source_port" != '$' ]; then
        iptable_cmd="$iptable_cmd --sport ${source_port}"
    fi

    if [ "$dest_port" = "Ephemeral" ]; then
        iptable_cmd="$iptable_cmd --dport ${ephemeral_start_port}:${ephemeral_end_port}"
    elif [ -n "$dest_port" ] && [ "$dest_port" != '$' ]; then
        iptable_cmd="$iptable_cmd --dport ${dest_port}"
    fi

    if [ -n "$source_ip" ] && [ "$source_ip" != '$' ] && [ "$source_ip" != "ANY" ]; then
        iptable_cmd="$iptable_cmd -s ${source_ip}"
    fi

    if [ -n "$dest_ip" ] && [ "$dest_ip" != '$' ] && [ "$dest_ip" != "ANY" ]; then
        iptable_cmd="$iptable_cmd -d ${dest_ip}"
    fi

    iptable_cmd="$iptable_cmd -j ACCEPT"
    /system/bin/iptables $iptable_cmd
}

############################### main ###############################
drop_rules
loopback_rules

IFS=',' read -r \
    header1 header2 header3 header4 header5 header6 header7 header8 header9 header10 \
    header11 header12 header13 header14 header15 header16 header17 header18 header19 header20 \
    header21 header22 header23 header24 header25 header26 header27 header28 < "$input_file"

tail -n +2 "$input_file" | while IFS=',' read -r \
    col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 \
    col11 col12 col13 col14 col15 col16 col17 col18 col19 col20 \
    col21 col22 col23 col24 col25 col26 col27 col28; do

    i=1
    while [ $i -le 28 ]; do
        eval "header_val=\$header$i"
        eval "col_val=\$col$i"
        case "$header_val" in
            "Ingress port") ingress_port="$col_val" ;;
            "Egress port") egress_port="$col_val" ;;
            *Protocol*) protocol="$col_val" ;;
            "Source IP Address") source_ip="$col_val" ;;
            "Destination IP Address") dest_ip="$col_val" ;;
            "Source Port") source_port="$col_val" ;;
            "Destination Port") dest_port="$col_val" ;;
        esac
        i=$((i + 1))
    done

    if [ "$ingress_port" = "P3" ] && [ "$ingress_port" != '$' ]; then
        install_iptable_rule "OUTPUT"
    fi

    if [ "$egress_port" = "P3" ] && [ "$egress_port" != '$' ]; then
        install_iptable_rule "INPUT"
    fi
done
echo "DEBUG: Exited main processing loop." > /dev/kmsg
echo "$0 finished." > /dev/kmsg
