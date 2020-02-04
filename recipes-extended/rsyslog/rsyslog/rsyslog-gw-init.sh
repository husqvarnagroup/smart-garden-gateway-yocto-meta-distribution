#!/bin/sh
# shellcheck disable=SC2154
#
# Setup gateway configuration for rsyslog

set -eu -o pipefail

RSYSLOG_CONFIG_DIR='/etc/rsyslog.d'
RSYSLOG_SPOOL_DIR='/var/spool/rsyslog'
SELUXIT_ENV="$(fw_printenv -n "seluxit_env" 2>/dev/null || echo prod)"

mkdir -p ${RSYSLOG_SPOOL_DIR}

# Configure gateway id as LocalHostName
RSYSLOG_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/01-gateway-id.conf"
if [ ! -s "${RSYSLOG_CONFIG_FILE}" ]; then
    mkdir -p ${RSYSLOG_CONFIG_DIR}
    echo "\$LocalHostName $(fw_printenv -n gatewayid)" > "${RSYSLOG_CONFIG_FILE}.tmp"
    sync
    mv "${RSYSLOG_CONFIG_FILE}.tmp" "${RSYSLOG_CONFIG_FILE}"
fi

# Configure variables for use in other config files
RSYSLOG_METADATA_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/02-gateway-metadata.conf"
if [ ! -s "${RSYSLOG_METADATA_CONFIG_FILE}" ]; then
    mkdir -p ${RSYSLOG_CONFIG_DIR}
    echo "set \$!gw.env = '$(SELUXIT_ENV)';" >> "${RSYSLOG_METADATA_CONFIG_FILE}.tmp"
    # shellcheck disable=SC1091
    echo "set \$!gw.swVersion = '$(. /etc/os-release; echo "$VERSION")';" >> "${RSYSLOG_METADATA_CONFIG_FILE}.tmp"
    sync
    mv "${RSYSLOG_METADATA_CONFIG_FILE}.tmp" "${RSYSLOG_METADATA_CONFIG_FILE}"
fi

# Configure diagnostics based on environment
DIAGNOSTICS_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/20-diagnostics.conf"
if [ "${SELUXIT_ENV}" = prod ]; then
    cmp "${DIAGNOSTICS_CONFIG_FILE}.prod" "${DIAGNOSTICS_CONFIG_FILE}" 2>/dev/null || cp "${DIAGNOSTICS_CONFIG_FILE}.prod" "${DIAGNOSTICS_CONFIG_FILE}"
else
    cmp "${DIAGNOSTICS_CONFIG_FILE}.dev" "${DIAGNOSTICS_CONFIG_FILE}" 2>/dev/null || cp "${DIAGNOSTICS_CONFIG_FILE}.dev" "${DIAGNOSTICS_CONFIG_FILE}"
fi

# Disable verbose logging on prod
FILTER_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/90-severity-forward-filter.conf"
RATELIMIT_CONFIG_FILE="${RSYSLOG_CONFIG_DIR}/90-rate-limit.conf"
if [ "${SELUXIT_ENV}" = prod ]; then
    cmp "${FILTER_CONFIG_FILE}.prod" "${FILTER_CONFIG_FILE}" 2>/dev/null || cp "${FILTER_CONFIG_FILE}.prod" "${FILTER_CONFIG_FILE}"
    cmp "${RATELIMIT_CONFIG_FILE}.prod" "${RATELIMIT_CONFIG_FILE}" 2>/dev/null || cp "${RATELIMIT_CONFIG_FILE}.prod" "${RATELIMIT_CONFIG_FILE}"
else
    rm -f "${FILTER_CONFIG_FILE}"
    rm -f "${RATELIMIT_CONFIG_FILE}"
fi
