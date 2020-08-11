# shellcheck disable=SC2148
# shellcheck disable=SC2154
# shellcheck shell=dash
#
# Environment provided by dhcpcd:
# ${new|old}_ntp_servers
# ${new|old}_dhcp6_sntp_servers
# $interface
# $reason
#
# Set NTP servers provided by DHCPv4 option 42 and/or DHCPv6 option 31 for use with
# systemd-timesyncd. The four default Husqvarna NTP servers will be preserved and
# appended to the list of available servers.
# All NTP server information is stored in individual files in the
# /etc/systemd/timesyncd.conf.d directory according to the timesyncd.conf(5) manpage.

SERVERFILE_IPV6="/etc/systemd/timesyncd.conf.d/10-dhcpcd-v6.conf"
SERVERFILE_IPV4="/etc/systemd/timesyncd.conf.d/20-dhcpcd-v4.conf"

# The build_config function is called only when there is a change to be commited from DHCPv4/v6.
build_config()
{
    cat <<EOF > "${SERVERFILE}"
# NTP servers received from DHCP
[Time]
NTP=$new_ntp_servers
EOF
    restart_needed=1
}

remove_servers()
{
    if [ -f "$SERVERFILE" ]; then
        rm -f "$SERVERFILE"
        restart_needed=1
    fi
}

update_servers()
{
    if [ -n "$new_ntp_servers" ]; then
        if [ "$new_ntp_servers" != "$old_ntp_servers" ]; then
            build_config
        fi
    else
        remove_servers
    fi
}

if [ "$interface" = eth0 ] || [ "$interface" = wlan0 ]; then
    case "$reason" in
    BOUND6|RENEW6|REBIND6|REBOOT6|INFORM6)
        SERVERFILE="$SERVERFILE_IPV6"
        new_ntp_servers="$new_dhcp6_sntp_servers"
        old_ntp_servers="$old_dhcp6_sntp_servers"
        update_servers
    ;;
    BOUND|RENEW|REBIND|REBOOT)
        SERVERFILE="$SERVERFILE_IPV4"
        update_servers
    ;;
    EXPIRE6|STOP6)
        SERVERFILE="$SERVERFILE_IPV6"
        remove_servers
    ;;
    EXPIRE|STOP)
        SERVERFILE="$SERVERFILE_IPV4"
        remove_servers
    ;;
    esac

    if [ -n "$restart_needed" ]; then
        systemctl try-restart systemd-timesyncd.service || true
    fi
fi
