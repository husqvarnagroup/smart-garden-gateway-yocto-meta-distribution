FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".0"

SYSTEMD_AUTO_ENABLE_ntpdate = "disable"
