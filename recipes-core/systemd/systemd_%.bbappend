FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://systemd-disable-colors.sh \
    file://keep.d/${PN} \
    file://0001-socket-util-fix-getpeergroups-assert-fd-8080.patch \
    file://0002-fd-util-move-certain-fds-above-fd-2-8129.patch \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${sysconfdir}/profile.d/systemd-disable-colors.sh \
"

PR_append = ".2"

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

	# systemd-firstboot.service: Do not wait for user input
	sed -i -e 's/.*ExecStart=.*/ExecStart=\/bin\/systemd-firstboot/' ${D}${systemd_unitdir}/system/systemd-firstboot.service

	# Keep relevant systemd data from being erased on update
	install -d ${D}${base_libdir}/upgrade/keep.d
	install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
