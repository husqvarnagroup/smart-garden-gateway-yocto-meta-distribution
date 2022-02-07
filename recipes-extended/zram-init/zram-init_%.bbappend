FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI += " \
    file://zram-run-log-journal.service \
    "

PR_append = ".0"

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/zram-run-log-journal.service ${D}${systemd_unitdir}/system/zram-run-log-journal.service
}

FILES_${PN} += " \
    ${systemd_unitdir} \
    "

RPROVIDES_${PN} += "${PN}-systemd"
RREPLACES_${PN} += "${PN}-systemd"
RCONFLICTS_${PN} += "${PN}-systemd"

# the meta-oe zram package would conflict with this package
RCONFLICTS_${PN} += "zram"

inherit systemd
SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE_${PN} += "zram-run-log-journal.service"
