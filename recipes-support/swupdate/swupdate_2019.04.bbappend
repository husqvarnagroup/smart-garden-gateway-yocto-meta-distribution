FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".1"

SRC_URI += " \
            file://2018-10-11-smart_gateway_mt7688-sw-update.cert.pem \
            file://disable_ubi_attach.cfg \
            file://disable_webserver.cfg \
            file://enable_bootloader.cfg \
            file://enable_download.cfg \
            file://enable_sha256.cfg \
            file://enable_signing_cms.cfg \
            file://enable_systemd.cfg \
            file://enable_ubi.cfg \
            file://ignore_expired_certificate.cfg \
            file://set_hw_revision_file_path.cfg \
            file://set_sw_versions_file_path.cfg \
            file://swupdate.cfg \
            file://swupdate-check.sh \
            file://swupdate-check.service \
            file://swupdate-check.timer \
            "

# The upstream recipe puts too much in the swupdate package
# a) slim down swupdate
FILES_${PN} = " \
    ${bindir}/swupdate \
"
# b) erase all unwanted files
do_install_append () {
    # HawkBit
    rm -r ${D}${bindir}/sendtohawkbit ${D}${bindir}/client ${D}${bindir}/hawkbitcfg ${D}${bindir}/progress ${D}${libdir}/tmpfiles.d
    # USB
    rm -r ${D}${sysconfdir}/udev ${D}${systemd_unitdir}/system/swupdate-usb@.service
    # www
    rm ${D}${systemd_unitdir}/system/swupdate.service
}
SYSTEMD_SERVICE_${PN}_remove = "swupdate.service swupdate-usb@.service"

# We need/abuse swupdate-progress to issue a reset after updating
FILES_${PN} += " \
    ${bindir}/swupdate-progress \
    ${systemd_unitdir}/system/swupdate-progress.service \
"
FILES_${PN}-tools_remove = "/usr/bin/swupdate-progress"
do_install_append () {
    install -m 0755 tools/progress_unstripped ${D}${bindir}/swupdate-progress
}

FILES_${PN} += " \
    ${datadir}/${PN}/sw-update.cert.pem \
    ${sysconfdir}/swupdate.cfg \
    ${systemd_unitdir}/system/swupdate-check.service \
    ${systemd_unitdir}/system/swupdate-check.timer \
    ${bindir}/swupdate-check \
"

do_install_append () {
    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-10-11-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem

    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}

    install -m 0755 ${WORKDIR}/swupdate-check.sh ${D}${bindir}/swupdate-check
    sed -i 's#@DISTRO_UPDATE_URL@#${DISTRO_UPDATE_URL}#g' ${D}${bindir}/swupdate-check

    install -m 644 ${WORKDIR}/swupdate-check.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/swupdate-check.timer ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN} += "swupdate-check.timer"

DEPENDS += "systemd curl"
RDEPENDS_${PN} += "components-introspection"
