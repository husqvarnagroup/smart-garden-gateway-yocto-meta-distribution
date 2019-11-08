FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://journald-ram.conf \
    file://journald-storage.conf \
    file://keep.d/${BPN} \
    file://system-logcolor.conf \
    file://system-watchdog.conf \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

PR_append = ".1"

do_install_append() {
    install -m 0644 ${WORKDIR}/system-watchdog.conf ${D}${systemd_unitdir}/system.conf.d/50-watchdog.conf

    # Disable colorized statup messages
    install -m 0644 ${WORKDIR}/system-logcolor.conf ${D}${systemd_unitdir}/system.conf.d/51-logcolor.conf

    # journald: Log to RAM, not storage
    install -m 0644 ${WORKDIR}/journald-storage.conf ${D}${systemd_unitdir}/journald.conf.d/50-storage.conf

    # journald: Set the maximium amount of memory for storing logs to 8M
    install -m 0644 ${WORKDIR}/journald-ram.conf ${D}${systemd_unitdir}/journald.conf.d/50-ram.conf

    # Keep relevant systemd data from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
