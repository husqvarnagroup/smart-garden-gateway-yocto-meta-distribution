FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".2"

SRC_URI += " \
	file://ntp.conf \
"

do_install:append() {
	install -m 0644 ${WORKDIR}/ntp.conf ${D}${sysconfdir}

	# Prevent systemd-timedated from messing with the service
	rm -r ${D}${systemd_unitdir}/ntp-units.d
}

FILES:${PN}:remove = " \
	${systemd_unitdir}/ntp-units.d/60-ntpd.list \
"

SYSTEMD_AUTO_ENABLE:ntpdate = "disable"
