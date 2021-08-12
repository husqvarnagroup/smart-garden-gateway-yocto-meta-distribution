SUMMARY = "OpenVPN configuration for Seluxit servers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "0.1"
PR = "0"

RDEPENDS_${PN} += "openvpn"

RPROVIDES_${PN} = "virtual/openvpn-config"

SRC_URI = " \
    file://prod.conf \
"

FILES_${PN} = " \
    ${sysconfdir}/openvpn \
"

do_install() {
    install -d ${D}${sysconfdir}/openvpn
    install -m 644 ${WORKDIR}/prod.conf ${D}${sysconfdir}/openvpn
}

inherit allarch
