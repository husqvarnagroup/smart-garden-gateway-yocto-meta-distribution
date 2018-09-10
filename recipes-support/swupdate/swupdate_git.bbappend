FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = 'be193ad2e19e8e81e6b1e0c6b194b8a7e18fad00'

PR = "r1"

SRC_URI += " \
            file://2018-09-03-smart_gateway_mt7688-sw-update.cert.pem \
            file://disable_webserver.cfg \
            file://enable_bootloader.cfg \
            file://enable_download.cfg \
            file://enable_sha256.cfg \
            file://enable_signing_cms.cfg \
            file://enable_systemd.cfg \
            file://enable_ubi.cfg \
            file://set_hw_revision_file_path.cfg \
            file://set_sw_versions_file_path.cfg \
            file://swupdate.cfg \
            file://swupdate-check \
            file://update-hw-revision \
            file://update-hw-revision.service \
            file://update-sw-versions \
            file://update-sw-versions.service \
            "

FILES_${PN} += " \
    ${datadir}/${PN}/sw-update.cert.pem \
    ${sysconfdir}/swupdate.cfg \
    ${systemd_unitdir}/update-hw-revision.service \
    ${systemd_unitdir}/update-sw-versions.service \
    ${bindir}/update-hw-revision \
    ${bindir}/update-sw-versions \
    ${bindir}/swupdate-check \
"

do_install_append () {
    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-09-03-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem

    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/swupdate-check ${D}${bindir}

    install -m 644 ${WORKDIR}/update-hw-revision.service ${D}${systemd_unitdir}/system
    install -m 755 ${WORKDIR}/update-hw-revision ${D}${bindir}

    install -m 644 ${WORKDIR}/update-sw-versions.service ${D}${systemd_unitdir}/system
    install -m 755 ${WORKDIR}/update-sw-versions ${D}${bindir}
}

SYSTEMD_SERVICE_${PN} += "update-hw-revision.service"
SYSTEMD_SERVICE_${PN} += "update-sw-versions.service"

DEPENDS += "systemd curl"
