FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".2"

RDEPENDS_${PN} += "ca-certificates environment"

SRC_URI += "\
    file://rsyslog.conf \
    file://rsyslog.d/10-shadoway-logs.conf \
    file://rsyslog-gw-init.service \
    file://rsyslog-gw-init.sh \
"

PACKAGECONFIG[impstats] = "--enable-impstats,--disable-impstats,,"

PACKAGECONFIG_append = " impstats"

do_install_append() {
    # Install rsyslog configuration
    install -d "${D}${sysconfdir}/rsyslog.d"
    install -m 644 ${WORKDIR}/rsyslog.conf ${D}${sysconfdir}/rsyslog.conf
    install -m 644 ${WORKDIR}/rsyslog.d/10-shadoway-logs.conf ${D}${sysconfdir}/rsyslog.d/10-shadoway-logs.conf

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
