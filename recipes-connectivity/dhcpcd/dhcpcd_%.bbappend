FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PR_append = ".3"

SRC_URI += " \
    file://0001-dont-crash-when-calling-ipv4ll-without-an-address-in-state.patch \
    file://40-swupdate-check.sh \
    file://dhcpcd.conf \
    file://dhcpcd.service \
    file://keep.d/${PN} \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/dhcpcd.service ${D}${systemd_unitdir}/system/

    install -d ${D}${libexecdir}/dhcpcd-hooks
    install -m 0644 ${WORKDIR}/40-swupdate-check.sh ${D}${libexecdir}/dhcpcd-hooks/40-swupdate-check

    # Keep DHCP Unique Identifier on updates
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}

inherit systemd
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "dhcpcd.service"
