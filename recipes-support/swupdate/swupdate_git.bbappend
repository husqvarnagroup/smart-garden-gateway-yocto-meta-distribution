FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = 'dfd1dbd764d02e7f2b1de586517b9c8f6210e14f'

SRC_URI += " \
    file://disable_webserver.cfg \
    file://enable_download.cfg \
    file://enable_sha256.cfg \
    file://enable_signing_cms.cfg \
    file://enable_systemd.cfg \
    file://enable_ubi.cfg \
    file://0001-core-ustrtoull-convert-zero-length-strings-to-0.patch \
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
