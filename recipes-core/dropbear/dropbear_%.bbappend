FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".0"

SRC_URI += "\
    file://keep.d/${PN} \
"
FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_install_append() {
    install -d ${D}${sysconfdir}/default
    echo 'DROPBEAR_EXTRA_ARGS="-s"' > ${D}${sysconfdir}/default/dropbear

    # Keep SSH host key from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
