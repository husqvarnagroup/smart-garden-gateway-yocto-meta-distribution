FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".4"

RDEPENDS_${PN} += "environment"

SRC_URI += " \
    file://dev.conf \
    file://openvpn.service \
    file://prod.conf \
    file://qa.conf \
"

FILES_${PN} += " \
    ${sysconfdir}/openvpn \
    ${systemd_unitdir}/system \
"

do_install_append() {
    install -d ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/dev.conf ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/prod.conf ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/qa.conf ${D}${sysconfdir}/openvpn

    install -m 644 ${WORKDIR}/openvpn.service ${D}${systemd_unitdir}/system
}

# Overwrite the loopback server/client from base recipe
do_install_append() {
    rm ${D}${systemd_unitdir}/system/openvpn@.service
}
SYSTEMD_SERVICE_${PN} = "openvpn.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

DEPENDS += "systemd"
