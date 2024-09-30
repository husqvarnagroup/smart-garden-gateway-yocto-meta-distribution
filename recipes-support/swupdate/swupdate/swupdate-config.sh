#!/bin/sh
#
# Copyright (c) 2024 GARDENA GmbH
#
# SPDX-License-Identifier: MIT
# shellcheck shell=dash
set -eu -o pipefail

DEFAULT_SERVER=https://updates-dev.iot.sg.dss.husqvarnagroup.net

# shellcheck source=/dev/null
. /etc/os-release

case $(cut -d ' ' -f 1 /etc/hw-revision) in
    smart-gateway-mt7688)
        mtd_blacklist="0 1 2 3 4"
        ;;
    smart-gateway-at91sam)
        mtd_blacklist="0 1"
        ;;
esac

globals_extra=""
(! fw_printenv bnw_cloud_tenant >/dev/null 2>&1 || [ "$(fw_printenv -n bnw_cloud_tenant)" = "sg-live" ]) &&
    globals_extra="no-downgrading = \"$VERSION_ID\";"

cat << EOF > /tmp/swupdate.cfg
globals :
{
	verbose = true;
	loglevel = 5;
	syslog = false;
	public-key-file = "/usr/share/swupdate/sw-update.cert.pem";
	mtd-blacklist = "$mtd_blacklist";
	$globals_extra
};

suricatta :
{
	id = "$(fw_printenv -n gatewayid 2>/dev/null)";
	tenant = "ddi";
	url = "$(fw_printenv -n update_server 2>/dev/null || echo $DEFAULT_SERVER)";
	sslkey = "/etc/ssl/private/client-prod.key";
	sslcert = "/etc/ssl/certs/client-prod.crt";
	nocheckcert = true;  # Only remove if we are certain that a failed time sync won't cause problems
};

identify : (
	{ name = "sw_version"; value = "$VERSION_ID"; },
	{ name = "hw_boardname"; value = "$(cut -d ' ' -f 1 /etc/hw-revision)"; },
	{ name = "hw_revision"; value = "$(cut -d ' ' -f 2 /etc/hw-revision)"; },
);
EOF

mv /tmp/swupdate.cfg /etc/swupdate.cfg
sync
