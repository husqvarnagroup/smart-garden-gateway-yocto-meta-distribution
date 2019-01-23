FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://keep.d/${PN} \
    file://systemd-disable-colors.sh \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${sysconfdir}/profile.d/systemd-disable-colors.sh \
"

PR_append = ".0"

do_install_append() {
	# Disable colorized output of system tools (systemctl, etc.)
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/systemd-disable-colors.sh ${D}${sysconfdir}/profile.d

	# systemd-firstboot.service: Do not wait for user input
	sed -i -e 's/.*ExecStart=.*/ExecStart=\/bin\/systemd-firstboot/' ${D}${systemd_unitdir}/system/systemd-firstboot.service

	# Use our own NTP server names
	sed -i 's/#NTP=.*/NTP=time1.iot.sg.dss.husqvarnagroup.net time2.iot.sg.dss.husqvarnagroup.net time3.iot.sg.dss.husqvarnagroup.net time4.iot.sg.dss.husqvarnagroup.net/' ${D}${sysconfdir}/systemd/timesyncd.conf

	# Keep relevant systemd data from being erased on update
	install -d ${D}${base_libdir}/upgrade/keep.d
	install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
