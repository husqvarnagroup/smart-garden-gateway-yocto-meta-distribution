FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://dhcpcd.conf \
    file://dhcpcd.service \
"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/dhcpcd.service ${D}${systemd_unitdir}/system/
}

inherit systemd
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "dhcpcd.service"
