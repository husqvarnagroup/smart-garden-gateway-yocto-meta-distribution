FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".2"

SRC_URI += " \
    file://keep.d/${BPN} \
"

SRC_URI_append_gardena-sg-at91sam = " \
    file://wpa_supplicant@.service \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_install_append() {
    # Keep on updates
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}

# SG-14607 Load rtl8xxxu in client mode
do_install_append_gardena-sg-at91sam() {
    install -m 644 ${WORKDIR}/wpa_supplicant@.service ${D}/${systemd_unitdir}/system/
}
