#!/bin/sh
#
# Extract OpenVPN client certificate and key from U-Boot.
#
# Since certificates files contain newlines and U-Boot variables can not contain
# such, newlines are encoded as the string "\n". Please escape properly as "\\\n"
# if you ever want the string "\n" to end up in the final file.
#
# Precondition: The directory /etc/openvpn has to exist

openvpn_dir="/etc/openvpn"

for ext in crt key; do
    if [ -f "${openvpn_dir}/client.${ext}" ]; then
        echo "File '${openvpn_dir}/client.${ext}' already exists"
    else
        content="$(fw_printenv -n conf_openvpn_${ext} 2>/dev/null)"
        if [ "$0" = "0" ]; then
            echo -e "${content}" > "${openvpn_dir}/client.${ext}"
        else
            echo "U-Boot variable 'conf_openvpn_${ext}' is missing!" >&2
            exit 1
        fi
    fi
done
