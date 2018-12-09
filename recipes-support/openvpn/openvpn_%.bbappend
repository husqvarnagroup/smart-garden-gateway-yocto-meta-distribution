FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://ca-dev.crt \
    file://ca-prod.crt \
    file://ca-qa.crt \
    file://openvpn-install-certs.sh \
    file://openvpn@.service \
    file://sg-cos-dev.conf \
    file://sg-cos-prod.conf \
    file://sg-cos-qa.conf \
"

FILES_${PN} += " \
    ${sysconfdir}/openvpn \
"

do_install_append() {
    install -d ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/sg-cos-dev.conf ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/sg-cos-prod.conf ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/sg-cos-qa.conf ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/ca-dev.crt ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/ca-prod.crt ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/ca-qa.crt ${D}${sysconfdir}/openvpn

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/openvpn-install-certs.sh ${D}${bindir}/openvpn-install-certs

    install -m 644 ${WORKDIR}/openvpn@.service ${D}${systemd_unitdir}/system
}

# Overwrite the loopback server/client from base recipe
SYSTEMD_SERVICE_${PN} = "openvpn@sg-cos-prod.service"

DEPENDS += "systemd"
