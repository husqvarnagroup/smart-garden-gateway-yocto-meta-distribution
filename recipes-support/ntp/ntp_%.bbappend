FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".1"

SRC_URI += " \
	file://ntp.conf \
"

do_install_append() {
	install -m 0644 ${WORKDIR}/ntp.conf ${D}${sysconfdir}
}

SYSTEMD_AUTO_ENABLE_ntpdate = "disable"
