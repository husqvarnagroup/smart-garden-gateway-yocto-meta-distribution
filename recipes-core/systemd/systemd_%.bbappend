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

	# Disable colorized statup messages
	sed -i 's/#LogColor=yes/LogColor=no/g' ${D}${sysconfdir}/systemd/system.conf

	# Disable colorized output of system tools (systemctl, etc.)
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/systemd-disable-colors.sh ${D}${sysconfdir}/profile.d

	# journald: Log to RAM, not storage
	sed -i -e 's/.*Storage=.*/Storage=volatile/' ${D}${sysconfdir}/systemd/journald.conf

	# journald: Set the maximium amount of memory for storing logs to 8M
	sed -i -e 's/.*RuntimeMaxUse.*/RuntimeMaxUse=8M/' ${D}${sysconfdir}/systemd/journald.conf
}
