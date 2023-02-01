# shellcheck disable=SC2148
# shellcheck shell=dash
# `interface` and `reason` are provided by dhcpcd
# shellcheck disable=SC2154
#
# Trigger an update attempt when the gateway gets connected to a network.
#
# Skip the update check if there is a marker file. That file is created
# by the Lua script embedded in the update image. As the marker file
# is located in `/tmp` it's removed when the GW is rebooted (e.g. after a
# successful update).
#
# We are not simply using CARRIER because then we could not guarantee that the
# IP connectivity is established by the time SWUpdate gets executed.

update_marker="/tmp/dhcp_fw_update_check_delay"

try_update()
{
    [ -e "${update_marker}" ] && return 0

    systemctl start swupdate-check.service
}

# The only interesting interfaces are Ethernet and WiFi
if [ "${interface}" = eth0 ] || [ "${interface}" = wlan0 ]; then
    if [ "${reason}" = BOUND ] || [ "${reason}" = BOUND6 ] || [ "${reason}" = ROUTERADVERT ]; then
        try_update
    fi
fi
