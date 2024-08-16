FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".0"

SRC_URI += " \
            file://0001-suricatta-Fix-nocheckcert-configuration.patch \
            file://10-suricatta \
            file://2018-10-11-smart_gateway_mt7688-sw-update.cert.pem \
            file://disable_ubi_attach.cfg \
            file://disable_webserver.cfg \
            file://enable_bootloader.cfg \
            file://enable_ddi.cfg \
            file://enable_download.cfg \
            file://enable_sha256.cfg \
            file://enable_signing_cms.cfg \
            file://enable_systemd.cfg \
            file://enable_ubi.cfg \
            file://ignore_expired_certificate.cfg \
            file://set_hw_revision_file_path.cfg \
            file://set_sw_versions_file_path.cfg \
            file://swupdate-config.sh \
            file://swupdate.cfg \
            file://swupdate.service_override.conf \
            "

# Move on with actually adapting the package to our needs
FILES:${PN} += " \
    ${bindir}/swupdate-config \
    ${datadir}/${PN}/sw-update.cert.pem \
    ${sysconfdir}/swupdate.cfg \
    ${sysconfdir}/swupdate/conf.d/10-suricatta \
    ${sysconfdir}/systemd/system/swupdate.service.d/override.conf \
"

do_install:append () {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/swupdate-config.sh ${D}${bindir}/swupdate-config

    install -d ${D}${datadir}/${PN}
    install -m 644 ${WORKDIR}/2018-10-11-smart_gateway_mt7688-sw-update.cert.pem ${D}${datadir}/${PN}/sw-update.cert.pem

    install -d ${D}${sysconfdir}/swupdate/conf.d
    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/10-suricatta ${D}${sysconfdir}/swupdate/conf.d

    install -d ${D}${sysconfdir}/systemd/system/swupdate.service.d
    install -m 0644 ${WORKDIR}/swupdate.service_override.conf \
        ${D}${sysconfdir}/systemd/system/swupdate.service.d/override.conf
}

RDEPENDS:${PN} += "${PN}-progress components-introspection"
