# shellcheck disable=SC2148
# shellcheck shell=dash
# ifcarrier and interface are provided by dhcpcd
# shellcheck disable=SC2154
#
# Workaround to purge the IP addres of the fixed-link mac0 interfaces whenever
# the carrier on eth0@mac0 (switch port 0) goes down.

if [ "${interface}" = eth0 ] && [ "${ifcarrier}" != up ]; then
  ip address flush dev mac0
fi
