FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

PACKAGECONFIG = "mbedtls"
