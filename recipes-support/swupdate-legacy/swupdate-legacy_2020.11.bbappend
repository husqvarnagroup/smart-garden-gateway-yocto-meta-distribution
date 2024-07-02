FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

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
            "

# The upstream recipe puts too much in the swupdate package.
do_install:append () {
     # Remove unwanted swupdate package content
     rm -r ${D}${bindir}/swupdate-sysrestart ${D}${libdir}/swupdate ${D}${libdir}/tmpfiles.d ${D}${systemd_unitdir}/system/swupdate.service ${D}${systemd_unitdir}/system/swupdate.socket
}
SYSTEMD_SERVICE:${PN}:remove = "swupdate.service swupdate.socket"

# We need/abuse swupdate-progress to issue a reset after updating
FILES:${PN}-progress:remove = " \
    ${libdir}/swupdate/conf.d/90-start-progress \
"
RDEPENDS:${PN} += "${PN}-progress"

# Move on with actually adapting the package to our needs
FILES:${PN} += " \
    ${datadir}/${PN}/sw-update.cert.pem \
    ${sysconfdir}/swupdate.cfg \
"

do_install:append () {
    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-10-11-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem

    install -d ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
}

RDEPENDS:${PN} += "components-introspection"
