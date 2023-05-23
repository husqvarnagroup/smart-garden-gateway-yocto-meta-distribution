FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".2"

SRC_URI += "\
    file://fstab \
"
