FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".2"

SRC_URI += "\
    file://fstab \
"
