FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".0"

SRC_URI += "\
    file://0001-ash-only-catch-unexpected-exceptions-in-PS1-expansio.patch \
"
