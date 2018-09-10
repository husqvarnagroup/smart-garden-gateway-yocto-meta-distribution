FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = 'be193ad2e19e8e81e6b1e0c6b194b8a7e18fad00'

SRC_URI += " \
            file://2018-09-03-smart_gateway_mt7688-sw-update.cert.pem \
            file://disable_webserver.cfg \
            file://enable_bootloader.cfg \
            file://enable_download.cfg \
            file://enable_sha256.cfg \
            file://enable_signing_cms.cfg \
            file://enable_systemd.cfg \
            file://enable_ubi.cfg \
            file://swupdate-check \
            file://swupdate.cfg \
            "

FILES_${PN} += " \
    /usr/share/swupdate/sw-update.cert.pem \
    /etc/swupdate.cfg \
"

do_install_append () {
    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-09-03-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem

    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/swupdate-check ${D}${bindir}
}

DEPENDS += "systemd curl"
