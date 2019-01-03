#!/bin/sh
#
# Extract OpenVPN client certificate and key from U-Boot.
#
# Since certificates files contain newlines and U-Boot variables can not contain
# such, newlines are encoded as the string "\n". Please escape properly as "\\\n"
# if you ever want the string "\n" to end up in the final file.
#
# Precondition: The directory /etc/openvpn has to exist

set -eu -o pipefail

openvpn_dir="/etc/openvpn"

for ext in crt key; do
    uboot_var="conf_openvpn_${ext}"
    file="${openvpn_dir}/client-prod.${ext}"
    if [ -f "${file}" ]; then
        echo "File '${file}' already exists"
        exit 0
    fi
    if content="$(fw_printenv -n "${uboot_var}" 2>/dev/null)"; then
        echo "${content}" | tr '%' '\n' > "${file}"
    else
        echo "U-Boot variable '${uboot_var}' is missing!" >&2
        exit 1
    fi
done
