FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".24"

DEPENDS += "openssl"
RDEPENDS:${PN} += "ca-certificates environment"

SRC_URI += "\
    file://husqvarna-gateway-remote-logging.crt \
    file://rsyslog-gw-init.service \
    file://rsyslog-gw-init.sh \
    file://rsyslog.conf \
    file://rsyslog.d/20-diagnostics.conf.dev \
    file://rsyslog.d/20-diagnostics.conf.prod \
    file://rsyslog.d/90-severity-forward-filter.conf.prod \
    file://rsyslog.d/90-templates.conf \
    file://rsyslog.service \
    file://fix-ossl-leak.patch \
"

PACKAGECONFIG[impstats] = "--enable-impstats,--disable-impstats,,"
PACKAGECONFIG[openssl] = "--enable-openssl,--disable-openssl,,"

PACKAGECONFIG:append = " impstats openssl"
PACKAGECONFIG:remove = "gnutls"

do_compile:append() {
    (cd tests && make syslog_caller)
}

do_install:append() {
    # Install rsyslog configuration
    install -d "${D}${sysconfdir}/rsyslog.d"
    install -m 644 ${WORKDIR}/rsyslog.conf ${D}${sysconfdir}/rsyslog.conf
    install -m 644 ${WORKDIR}/rsyslog.d/20-diagnostics.conf.dev ${D}${sysconfdir}/rsyslog.d/20-diagnostics.conf.dev
    install -m 644 ${WORKDIR}/rsyslog.d/20-diagnostics.conf.prod ${D}${sysconfdir}/rsyslog.d/20-diagnostics.conf.prod
    install -m 644 ${WORKDIR}/rsyslog.d/90-severity-forward-filter.conf.prod ${D}${sysconfdir}/rsyslog.d/90-severity-forward-filter.conf.prod
    install -m 644 ${WORKDIR}/rsyslog.d/90-templates.conf ${D}${sysconfdir}/rsyslog.d/90-templates.conf

    # Allow rsyslog-gw-init to access the vanilla configuration at any time
    cp "${D}${sysconfdir}/rsyslog.conf" "${D}${sysconfdir}/rsyslog.conf.prod"

    # Install rsyslog gateway init script
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/rsyslog-gw-init.sh ${D}${bindir}/rsyslog-gw-init

    # Install systemd unit files
    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/rsyslog-gw-init.service ${D}${systemd_unitdir}/system
    sed -i -e 's,@BINDIR@,${bindir},g' \
        ${D}${systemd_unitdir}/system/rsyslog-gw-init.service

    # Overwrite upstream service file
    install -m 644 ${WORKDIR}/rsyslog.service ${D}${systemd_unitdir}/system

    # Create directory for our serialized messages
    install -d ${D}${localstatedir}/spool/rsyslog

    # Install the syslog_caller binary
    cp ${B}/${TESTDIR}/syslog_caller ${D}${bindir}/rsyslog-syslog_caller

    # Install self-singed server certificate
    install -Dm 0644 ${WORKDIR}/husqvarna-gateway-remote-logging.crt ${D}${sysconfdir}/ssl/certs/husqvarna-gateway-remote-logging.crt
}

SYSTEMD_SERVICE:${PN} += "rsyslog-gw-init.service"

PACKAGES =+ "\
    ${PN}-syslog-caller \
"
RDEPENDS:${PN}-syslog-caller += "liblogging"
FILES:${PN}-syslog-caller += "${bindir}/rsyslog-syslog_caller"
