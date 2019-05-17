#!/bin/sh
#
# Extract OpenVPN client certificate and key from U-Boot.
#
# Since certificates files contain newlines and U-Boot variables can not contain
# such, newlines are encoded as the string "%".
#
# Precondition: The directory /etc/openvpn has to exist

set -eu -o pipefail

openvpn_dir="/etc/openvpn"
seluxit_env="$(fw_printenv -n "seluxit_env" 2>/dev/null || echo prod)"

for ext in crt key; do
    file="${openvpn_dir}/client-${seluxit_env}.${ext}"
    if [ "${seluxit_env}" = prod ]; then
        uboot_var="conf_openvpn_${ext}"
    else
        uboot_var="conf_openvpn_${seluxit_env}_${ext}"
    fi
    if [ -s "${file}" ]; then
        echo "File '${file}' already exists and is not empty"
        continue
    fi
    if content="$(fw_printenv -n "${uboot_var}" 2>/dev/null)"; then
        echo "${content}" | tr '%' '\n' > "${file}".tmp
        sync
        mv "${file}".tmp "${file}"
    else
        echo "U-Boot variable '${uboot_var}' is missing!" >&2
        exit 1
    fi
done

seluxit_env_file_name="/etc/seluxit_env"
seluxit_env_file_content="SELUXIT_ENV=${seluxit_env}"

if [ "$(head -n1 "${seluxit_env_file_name}")" != "${seluxit_env_file_content}" ]; then
    echo "Updating Seluxit environment file"
    echo "${seluxit_env_file_content}" > "${seluxit_env_file_name}"
fi
