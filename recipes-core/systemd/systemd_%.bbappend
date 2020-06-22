FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://keep.d/${BPN} \
    file://systemd-disable-colors.sh \
    file://systemd-disable-pager.sh \
    file://99-husqvarna-default.conf \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${sysconfdir}/profile.d/systemd-disable-colors.sh \
    ${sysconfdir}/profile.d/systemd-disable-pager.sh \
"

PR_append = ".3"

do_install_append() {
	# Disable colorized output of system tools (systemctl, etc.)
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/systemd-disable-colors.sh ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/systemd-disable-pager.sh ${D}${sysconfdir}/profile.d

	# Always append our own NTP server names as a default (99- takes a very low precedence)
	install -d ${D}${sysconfdir}/systemd/timesyncd.conf.d
	install -m 0644 ${WORKDIR}/99-husqvarna-default.conf ${D}${sysconfdir}/systemd/timesyncd.conf.d

	# Keep relevant systemd data from being erased on update
	install -d ${D}${base_libdir}/upgrade/keep.d
	install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}

# Removed due to SG-12020
PACKAGECONFIG_remove = "resolved nss-resolve"
