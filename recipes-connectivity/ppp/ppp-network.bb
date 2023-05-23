SUMMARY = "Provide BNW IP configuration for ppp0"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PV = "0.1"

SRC_URI = " \
    file://99-ppp0.network \
"

do_install() {
    install -d 0755 ${D}${systemd_unitdir}/network
    install -m 0644 "${WORKDIR}/99-ppp0.network" "${D}${systemd_unitdir}/network"

}

FILES:${PN} += "\
    ${systemd_unitdir}/network \
"

RDEPENDS:${PN} += " \
    ppp \
"
