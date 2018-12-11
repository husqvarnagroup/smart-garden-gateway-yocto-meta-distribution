FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = '8c8db83ba3ee0b017321d8977f382b9c0b14a7bf'

PR_append = ".1"

SRC_URI += " \
            file://2018-10-11-smart_gateway_mt7688-sw-update.cert.pem \
            file://0001-handlers-bootloader-let-comments-and-blankline-in-im.patch \
            file://disable_ubi_attach.cfg \
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
            file://swupdate-check.service \
            file://swupdate-check.timer \
            file://update-hw-revision \
            file://update-hw-revision.service \
            file://update-sw-versions \
            file://update-sw-versions.service \
            "

FILES_${PN} += " \
    ${datadir}/${PN}/sw-update.cert.pem \
    ${sysconfdir}/swupdate.cfg \
    ${systemd_unitdir}/system/update-hw-revision.service \
    ${systemd_unitdir}/system/update-sw-versions.service \
    ${systemd_unitdir}/system/swupdate-check.service \
    ${systemd_unitdir}/system/swupdate-check.timer \
    ${bindir}/update-hw-revision \
    ${bindir}/update-sw-versions \
    ${bindir}/swupdate-check \
"

do_install_append () {
    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-10-11-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem

    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}

    install -m 0755 ${WORKDIR}/swupdate-check ${D}${bindir}
    install -m 644 ${WORKDIR}/swupdate-check.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/swupdate-check.timer ${D}${systemd_unitdir}/system

    install -m 644 ${WORKDIR}/update-hw-revision.service ${D}${systemd_unitdir}/system
    install -m 755 ${WORKDIR}/update-hw-revision ${D}${bindir}

    install -m 644 ${WORKDIR}/update-sw-versions.service ${D}${systemd_unitdir}/system
    install -m 755 ${WORKDIR}/update-sw-versions ${D}${bindir}
}

SYSTEMD_SERVICE_${PN} += "update-hw-revision.service"
SYSTEMD_SERVICE_${PN} += "update-sw-versions.service"
SYSTEMD_SERVICE_${PN} += "swupdate-check.timer"

DEPENDS += "systemd curl"
