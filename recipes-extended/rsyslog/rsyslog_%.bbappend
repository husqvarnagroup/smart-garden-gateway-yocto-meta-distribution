FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".6"

DEPENDS += "openssl"
RDEPENDS_${PN} += "ca-certificates environment"

SRC_URI += "\
    file://rsyslog.conf \
    file://rsyslog.d/20-impstats.conf \
    file://rsyslog.d/90-rate-limit.conf.prod \
    file://rsyslog.d/90-severity-forward-filter.conf.prod \
    file://rsyslog.d/90-templates.conf \
    file://rsyslog-gw-init.service \
    file://rsyslog-gw-init.sh \
"

PACKAGECONFIG[impstats] = "--enable-impstats,--disable-impstats,,"
PACKAGECONFIG[openssl] = "--enable-openssl,--disable-openssl,,"

PACKAGECONFIG_append = " impstats openssl"
PACKAGECONFIG_remove = "gnutls"

do_install_append() {
    # Install rsyslog configuration
    install -d "${D}${sysconfdir}/rsyslog.d"
    install -m 644 ${WORKDIR}/rsyslog.conf ${D}${sysconfdir}/rsyslog.conf
    install -m 644 ${WORKDIR}/rsyslog.d/20-impstats.conf ${D}${sysconfdir}/rsyslog.d/20-impstats.conf
    install -m 644 ${WORKDIR}/rsyslog.d/90-rate-limit.conf.prod ${D}${sysconfdir}/rsyslog.d/90-rate-limit.conf.prod
    install -m 644 ${WORKDIR}/rsyslog.d/90-severity-forward-filter.conf.prod ${D}${sysconfdir}/rsyslog.d/90-severity-forward-filter.conf.prod
    install -m 644 ${WORKDIR}/rsyslog.d/90-templates.conf ${D}${sysconfdir}/rsyslog.d/90-templates.conf

    # Install rsyslog gateway init script
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/rsyslog-gw-init.sh ${D}${bindir}/rsyslog-gw-init

    # Install systemd unit files
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/rsyslog-gw-init.service ${D}${systemd_unitdir}/system
    sed -i -e 's,@BINDIR@,${bindir},g' \
        ${D}${systemd_unitdir}/system/rsyslog-gw-init.service
}

SYSTEMD_SERVICE_${PN} += "rsyslog-gw-init.service"
