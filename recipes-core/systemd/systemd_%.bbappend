FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://systemd-disable-colors.sh \
"

FILES_${PN} += "\
    ${sysconfdir}/profile.d/systemd-disable-colors.sh \
"

do_install_append() {
	sed -i 's/#RuntimeWatchdogSec=0/RuntimeWatchdogSec=60/g' ${D}${sysconfdir}/systemd/system.conf
	sed -i 's/#ShutdownWatchdogSec=10min/ShutdownWatchdogSec=1min/g' ${D}${sysconfdir}/systemd/system.conf

	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/systemd-disable-colors.sh ${D}${sysconfdir}/profile.d
}
