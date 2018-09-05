FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = 'd8069ae82853c2dc6b8400a29ec51b1b556e4134'

SRC_URI += " \
    file://disable_webserver.cfg \
    file://enable_download.cfg \
    file://enable_sha256.cfg \
    file://enable_signing_cms.cfg \
    file://enable_systemd.cfg \
    file://enable_ubi.cfg \
    file://enable_bootloader.cfg \
    file://2018-09-03-smart_gateway_mt7688-sw-update.cert.pem \
"

FILES_${PN} += " \
    /usr/share/swupdate/sw-update.cert.pem \
"

do_install_append () {
    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-09-03-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem
}

DEPENDS += "systemd curl"
