#!/bin/sh
# shellcheck disable=SC2154
#
# Setup gateway configuration for rsyslog

set -eu -o pipefail

RSYSLOG_CONFIG_DIR='/etc/rsyslog.d'
RSYSLOG_SPOOL_DIR='/var/spool/rsyslog'

mkdir -p ${RSYSLOG_SPOOL_DIR}

# Configure gateway id as LocalHostName
RSYSLOG_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/01-gateway-id.conf"
if [ ! -s "${RSYSLOG_CONFIG_FILE}" ]; then
    mkdir -p ${RSYSLOG_CONFIG_DIR}
    echo "\$LocalHostName $(fw_printenv -n gatewayid)" > "${RSYSLOG_CONFIG_FILE}.tmp"
    sync
    mv "${RSYSLOG_CONFIG_FILE}.tmp" "${RSYSLOG_CONFIG_FILE}"
fi

# Disable verbose logging on prod
FILTER_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/90-severity-forward-filter.conf"
SELUXIT_ENV="$(fw_printenv -n "seluxit_env" 2>/dev/null || echo prod)"
if [ "${SELUXIT_ENV}" = prod ] && [ ! -s "${FILTER_CONFIG_FILE}" ]; then
    cat > "${FILTER_CONFIG_FILE}.tmp" <<\EOF
# don't forward notice, info & debug logs
if $syslogseverity >= 5 then stop
EOF
    sync
    mv "${FILTER_CONFIG_FILE}.tmp" "${FILTER_CONFIG_FILE}"
else
    rm -f "${FILTER_CONFIG_FILE}"
fi
