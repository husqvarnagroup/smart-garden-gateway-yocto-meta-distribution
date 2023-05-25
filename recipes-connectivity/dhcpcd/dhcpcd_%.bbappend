FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PR:append = ".4"

SRC_URI += " \
    file://40-swupdate-check.sh \
    file://50-timesyncd.conf.sh \
    file://dhcpcd.conf \
    file://keep.d/${BPN} \
"

FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf

    install -d ${D}${libexecdir}/dhcpcd-hooks
    install -m 0644 ${WORKDIR}/40-swupdate-check.sh ${D}${libexecdir}/dhcpcd-hooks/40-swupdate-check
    install -m 0644 ${WORKDIR}/50-timesyncd.conf.sh ${D}${libexecdir}/dhcpcd-hooks/50-timesyncd.conf

    # Keep DHCP Unique Identifier on updates
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
