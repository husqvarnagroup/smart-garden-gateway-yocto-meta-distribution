FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://keep.d/${PN} \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

PR_append = ".0"

do_install_append() {
	sed -i 's/.*RuntimeWatchdogSec=.*/RuntimeWatchdogSec=60/g' ${D}${sysconfdir}/systemd/system.conf
	sed -i 's/.*ShutdownWatchdogSec=.*/ShutdownWatchdogSec=1min/g' ${D}${sysconfdir}/systemd/system.conf

	# Disable colorized statup messages
	sed -i 's/.*LogColor=.*/LogColor=no/g' ${D}${sysconfdir}/systemd/system.conf

	# journald: Log to RAM, not storage
	sed -i -e 's/.*Storage=.*/Storage=volatile/' ${D}${sysconfdir}/systemd/journald.conf

	# journald: Set the maximium amount of memory for storing logs to 8M
	sed -i -e 's/.*RuntimeMaxUse.*/RuntimeMaxUse=8M/' ${D}${sysconfdir}/systemd/journald.conf

	# Keep relevant systemd data from being erased on update
	install -d ${D}${base_libdir}/upgrade/keep.d
	install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
