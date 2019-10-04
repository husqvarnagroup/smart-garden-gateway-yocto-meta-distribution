#!/bin/sh
# shellcheck disable=SC2154
#
# Setup gateway configuration for rsyslog
#
# For certificate handling, see openvpn-install-certs

set -eu -o pipefail

RSYSLOG_CONFIG_DIR='/etc/rsyslog.d'
RSYSLOG_SPOOL_DIR='/var/spool/rsyslog'

mkdir ${RSYSLOG_SPOOL_DIR} 2>/dev/null || true
mkdir ${RSYSLOG_CONFIG_DIR} 2>/dev/null || true

# Configure gateway id as LocalHostName
echo "\$LocalHostName $(fw_printenv -n gatewayid)" > "${RSYSLOG_CONFIG_DIR}/01-gateway-id.conf"

# Use seluxit certificate for authentication
SELUXIT_ENV="$(fw_printenv -n "seluxit_env" 2>/dev/null || echo prod)"
for ext in crt key; do
    FILE="${RSYSLOG_CONFIG_DIR}/auth.${ext}"
    if [ "${SELUXIT_ENV}" = prod ]; then
        UBOOT_VAR="conf_openvpn_${ext}"
    else
        UBOOT_VAR="conf_openvpn_${SELUXIT_ENV}_${ext}"
    fi

    if content="$(fw_printenv -n "${UBOOT_VAR}" 2>/dev/null)"; then
        echo "${content}" | tr '%' '\n' > "${FILE}".tmp
        sync
        mv "${FILE}".tmp "${FILE}"
    else
        echo "U-Boot variable '${UBOOT_VAR}' is missing!" >&2
        exit 1
    fi
done

# Disable verbose logging on prod
FILTER_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/90-shadoway-forward-filter.conf"
if [ "${SELUXIT_ENV}" = prod ]; then
    cat > ${FILTER_CONFIG_FILE} <<\EOF
# don't forward shadoway notice, info & debug logs
if $programname == ['shadoway', 'shadoway-proxy'] and $syslogseverity >= 5 then stop
EOF
else
    rm ${FILTER_CONFIG_FILE} 2>/dev/null || true
fi