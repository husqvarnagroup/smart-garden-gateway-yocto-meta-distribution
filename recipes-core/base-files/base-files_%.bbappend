FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".3"

SRC_URI += "\
    file://fstab \
"
