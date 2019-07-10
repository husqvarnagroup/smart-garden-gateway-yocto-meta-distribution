FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".2"

SRC_URI += "file://0001-add-lemonbeat-ports.patch \
            file://0002-add-homekit-accessory-protocol-port.patch \
            "

