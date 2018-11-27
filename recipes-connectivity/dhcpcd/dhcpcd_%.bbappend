FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://99-dns-routes \
    file://dhcpcd.conf \
    file://dhcpcd.service \
"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf

    install -d ${D}${libdir}/dhcpcd/dhcpcd-hooks
    install -m 0644 ${WORKDIR}/99-dns-routes ${D}${libdir}/dhcpcd/dhcpcd-hooks

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/dhcpcd.service ${D}${systemd_unitdir}/system/
}

inherit systemd
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "dhcpcd.service"
