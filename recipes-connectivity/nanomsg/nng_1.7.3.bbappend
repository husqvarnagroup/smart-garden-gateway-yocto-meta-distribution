FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

SRC_URI += " \
    file://0001-Add-nng_tls_config_hold-stub-function.patch \
"
