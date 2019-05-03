# shellcheck disable=SC2148
# shellcheck shell=dash
# if_up and interface are provided by dhcpcd
# shellcheck disable=SC2154

# dhcpcd-run-hooks reasons we are dealing with:
#
# BOUND/BOUND6: dhcpcd obtained a new lease from a DHCP server.
#               Works for all networks with a DHCP server. Very common
#               nowadays, but we require it to exist only when using IPv4
#               connectivity. IPv6 only networks might not have one.
#               Considering this limitation as acceptable because this update-on-brief-
#               disconnect is used mainly by developers.
#
# Not reacting on CARRIER because it is not guaranteed that the IP connectivity
# is established by the time SWUpdate gets executed.

case "${reason}" in
    BOUND | BOUND6)
        case "${interface}" in
            eth0 | wlan0)
                systemctl restart swupdate-check.timer || true
                ;;
        esac
        ;;
esac
