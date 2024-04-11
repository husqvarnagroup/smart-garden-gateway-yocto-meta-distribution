DESCRIPTION = "Service running SWUpdate periodically"
MAINTAINER = "Gardena GmbH"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INC_PR = "r5"

FILESEXTRAPATHS:prepend := "${THISDIR}/swupdate-check:"

SRC_URI = " \
    file://swupdate-check.sh \
    file://swupdate-check.service \
    file://swupdate-check.timer \
"

FILES:${PN} = " \
    ${systemd_unitdir}/system/swupdate-check.service \
    ${systemd_unitdir}/system/swupdate-check.timer \
    ${bindir}/swupdate-check \
"

RDEPENDS:${PN} = " \
    components-introspection \
    swupdate \
    virtual/os-release \
"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/swupdate-check.sh ${D}${bindir}/swupdate-check
    sed -i 's#@DISTRO_UPDATE_URL@#${DISTRO_UPDATE_URL}#g' ${D}${bindir}/swupdate-check
    sed -i 's#@DISTRO_VERSION_ID@#${DISTRO_VERSION_ID}#g' ${D}${bindir}/swupdate-check

    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/swupdate-check.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/swupdate-check.timer ${D}${systemd_unitdir}/system
}

inherit systemd
SYSTEMD_SERVICE:${PN} = " \
    swupdate-check.timer \
"
