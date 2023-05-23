FILESEXTRAPATHS:append := "${THISDIR}/files:"

SRC_URI += " \
    file://zram-run-log-journal.service \
    "

PR:append = ".0"

do_install:append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/zram-run-log-journal.service ${D}${systemd_unitdir}/system/zram-run-log-journal.service
}

FILES:${PN} += " \
    ${systemd_unitdir} \
    "

RPROVIDES:${PN} += "${PN}-systemd"
RREPLACES:${PN} += "${PN}-systemd"
RCONFLICTS:${PN} += "${PN}-systemd"

# the meta-oe zram package would conflict with this package
RCONFLICTS:${PN} += "zram"

inherit systemd
SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE:${PN} += "zram-run-log-journal.service"
