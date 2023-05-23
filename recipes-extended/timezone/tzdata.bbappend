FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

SRC_URI += "\
    file://keep.d/${BPN} \
"
FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_install:append() {
    # Prevent localtime and timezone from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
