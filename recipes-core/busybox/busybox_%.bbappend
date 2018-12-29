FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".0"

SRC_URI += "\
    file://display-error-on-nonzero-status.sh \
    file://enable_pgrep.cfg \
    file://enable_pkill.cfg \
"

FILES_${PN} += "\
    ${sysconfdir}/profile.d/display-error-on-nonzero-status.sh \
"

do_install_append() {
	# print error on non-zero exit status
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/display-error-on-nonzero-status.sh ${D}${sysconfdir}/profile.d
}
