require ppp-network.inc

# Prefer our customized files
FILESEXTRAPATHS:prepend := "${THISDIR}/ppp-network-zephyr:"

PR:append = ".0"
