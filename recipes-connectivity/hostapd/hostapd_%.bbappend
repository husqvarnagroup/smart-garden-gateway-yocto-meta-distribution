FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR_append = ".0"

SRC_URI += " \
    file://hostapd-CVE-2018-14526.patch \
"
