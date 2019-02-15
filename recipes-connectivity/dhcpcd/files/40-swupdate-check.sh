# shellcheck disable=SC2148
# shellcheck shell=dash
# if_up and interface are provided by dhcpcd
# shellcheck disable=SC2154

# Attempt update when connected to a new network

if [ "${if_up}" = "true" ]; then
    case "${interface}" in
        eth0 | wlan0)
            systemctl restart swupdate-check.timer || true
            ;;
    esac
fi
