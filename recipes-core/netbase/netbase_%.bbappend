FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".1"

SRC_URI += "file://0001-add-lemonbeat-ports.patch"

