SUMMARY = "IP configuration and services for ppp0"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/ppp-network:"

SRC_URI = " \
    file://99-ppp0.network \
    file://ppp-failure.service \
    file://ppp.service \
"

do_install() {
    install -d 0755 "${D}${systemd_unitdir}/network" "${D}${systemd_unitdir}/system"
    install -m 0644 "${WORKDIR}/99-ppp0.network" "${D}${systemd_unitdir}/network"
    install -m 0644 "${WORKDIR}/ppp-failure.service" "${D}${systemd_unitdir}/system"
    install -m 0644 "${WORKDIR}/ppp.service" "${D}${systemd_unitdir}/system"

    sed -i -e 's,@SBINDIR@,${sbindir},g' \
        -e 's,@TTY@,${RADIO_MODULE_PPP_TTY},g' \
        "${D}${systemd_unitdir}/system/ppp.service"
}

FILES:${PN} += "\
    ${systemd_unitdir}/network \
    ${systemd_unitdir}/system \
"

RDEPENDS:${PN} += " \
    ppp \
    virtual/gardena-gateway-firmware \
"

inherit systemd
SYSTEMD_SERVICE:${PN} = "ppp.service"

PR = "r3"
