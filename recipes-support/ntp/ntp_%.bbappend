FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

SRC_URI += " \
	file://ntp.conf \
"

do_install:append() {
	install -m 0644 ${WORKDIR}/ntp.conf ${D}${sysconfdir}
}

SYSTEMD_AUTO_ENABLE:ntpdate = "disable"
