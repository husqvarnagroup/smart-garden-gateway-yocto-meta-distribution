# shellcheck disable=SC2148
# shellcheck shell=dash
# if_up and interface are provided by dhcpcd
# shellcheck disable=SC2154
#
# Best-effort solution to trigger an update attempt when the gateway gets
# connected to a network.
#
# We are not simply using CARRIER because then we could not guaranteed that the
# IP connectivity is established by the time SWUpdate gets executed.

update_marker="/var/volatile/dhcpcd-swupdate-triggered"

try_update()
{
    [ -e "${update_marker}" ] && return 0

    systemctl restart swupdate-check.timer
    touch "${update_marker}"
}

# The only interesting interfaces are Ethernet and WiFi
if [ "${interface}" = eth0 ] || [ "${interface}" = wlan0 ]; then
    if $if_down; then
        rm -f "${update_marker}"
    elif [ "$reason" = BOUND ] || [ "$reason" = BOUND6 ] || [ "$reason" = ROUTERADVERT ]; then
        try_update
    fi
fi
