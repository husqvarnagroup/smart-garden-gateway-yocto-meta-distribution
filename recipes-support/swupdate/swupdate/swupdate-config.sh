#!/bin/sh
#
# Copyright (c) 2024 GARDENA GmbH
#
# SPDX-License-Identifier: MIT
# shellcheck shell=dash
set -eu -o pipefail

DEFAULT_SERVER=https://updates-dev.iot.sg.dss.husqvarnagroup.net

cp /media/rfs/ro/etc/swupdate.cfg /tmp/swupdate.cfg

# shellcheck source=/dev/null
. /etc/os-release

cat << EOF >> /tmp/swupdate.cfg

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
