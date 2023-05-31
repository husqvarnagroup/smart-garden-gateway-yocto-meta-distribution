FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".6"

SRC_URI += "\
    file://display-error-on-nonzero-status.sh \
    file://busybox.cfg \
"

FILES:${PN} += "\
    ${sysconfdir}/profile.d/display-error-on-nonzero-status.sh \
"

do_install:append() {
	# print error on non-zero exit status
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/display-error-on-nonzero-status.sh ${D}${sysconfdir}/profile.d
}
