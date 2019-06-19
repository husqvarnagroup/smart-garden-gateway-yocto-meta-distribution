#!/bin/sh
#
# This script extracts the board name and hardware version from U-Boot
# and saves those values in order to allow SWUpdate to determine the
# hardware it is running on.

set -u

board_name="$(fw_printenv -n board_name 2>/dev/null)"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
    echo "Failed to extract the board name from the U-Boot environment!" >&2
    board_name=smart-gateway-mt7688
fi

board_revision="$(fw_printenv -n gateway_hardware_revision 2>/dev/null)"
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
    echo "Failed to extract the board revision from the U-Boot environment!" >&2
    board_revision="unknown"
fi

echo "${board_name} ${board_revision}" > /tmp/hw-revision
