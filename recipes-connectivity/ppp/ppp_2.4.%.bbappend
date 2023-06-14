FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".0"

SRC_URI += " \
    file://0001-pppd-Set-local-and-remote-IPv6-addresses-by-one-call.patch \
"
