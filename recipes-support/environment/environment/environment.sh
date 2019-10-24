#!/bin/sh
#
# Extract X.509 client certificate and key from U-Boot.
#
# Since certificates files contain newlines and U-Boot variables can not contain
# such, newlines are encoded as the string "%".
#
# Precondition: The directories /etc/ssl/{certs,private} have to exist

set -eu -o pipefail

ssl_dir="/etc/ssl"
seluxit_env="$(fw_printenv -n "seluxit_env" 2>/dev/null || echo prod)"

# Remote logging always needs prod certificates
if [ "${seluxit_env}" != prod ]; then
    environments="${seluxit_env} prod"
else
    environments="${seluxit_env}"
fi
    
for environment in ${environments}; do
    for ext in crt key; do
        if [ "${ext}" = crt ]; then
            file="${ssl_dir}/certs/client-${environment}.${ext}"
        else
            file="${ssl_dir}/private/client-${environment}.${ext}"
        fi

        if [ "${environment}" = prod ]; then
            uboot_var="conf_openvpn_${ext}"
        else
            uboot_var="conf_openvpn_${environment}_${ext}"
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
done

seluxit_env_file_name="/etc/seluxit_env"
seluxit_env_file_content="SELUXIT_ENV=${seluxit_env}"

if [ "$(head -n1 "${seluxit_env_file_name}")" != "${seluxit_env_file_content}" ]; then
    echo "Updating Seluxit environment file"
    echo "${seluxit_env_file_content}" > "${seluxit_env_file_name}"
fi
