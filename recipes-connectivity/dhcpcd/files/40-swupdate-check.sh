# shellcheck disable=SC2148
# shellcheck shell=dash
# if_up and interface are provided by dhcpcd
# shellcheck disable=SC2154
#
# Best-effort solution to trigger an update attempt when the gateway gets
# connected to a network.
#
# dhcpcd-run-hooks reasons we want to deal with:
#
# BOUND/BOUND6: dhcpcd obtained a new lease from a DHCP server.
#               Works for all networks with a DHCP server. Very common
#               nowadays, but we require it to exist only when using IPv4
#               connectivity. IPv6 only networks might not have one.
# ROUTERADVERT: dhcpcd has received an IPv6 router advertisement, or one has
#               expired.
#               Received regularly in IPv6 networks even when DHCP is not used.
#               We must not trigger an update attempt for every message, but
#               just one single time after a carrier has come back up.
#               Please note that this script does not trigger an update attempt
#               when a new route has been advertised.
# NOCARRIER:    When received, causes the next ROUTERADVERT to trigger an
#               update.
# CARRIER:      Not being used because it is not guaranteed that the IP
#               connectivity is established by the time SWUpdate gets executed.

update_marker="/var/volatile/dhcpcd-swupdate-triggered"

try_update()
{
    [ -e "${update_marker}" ] && return 0

    systemctl restart swupdate-check.timer || true
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
