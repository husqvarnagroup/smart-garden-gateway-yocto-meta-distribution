FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://journald-ram.conf \
    file://journald-storage.conf \
    file://keep.d/${BPN} \
    file://system-cpuaccounting.conf \
    file://system-dumpcore.conf \
    file://system-logcolor.conf \
    file://system-watchdog.conf \
"

FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

PR:append = ".5"

do_install:append() {
    install -m 0644 ${WORKDIR}/system-watchdog.conf ${D}${systemd_unitdir}/system.conf.d/50-watchdog.conf

    # Disable colorized statup messages
    install -m 0644 ${WORKDIR}/system-logcolor.conf ${D}${systemd_unitdir}/system.conf.d/51-logcolor.conf

    # Disable core dumps per default
    install -m 0644 ${WORKDIR}/system-dumpcore.conf ${D}${systemd_unitdir}/system.conf.d/52-dumpcore.conf

    # Enable CPU accounting per default
    install -m 0644 ${WORKDIR}/system-cpuaccounting.conf ${D}${systemd_unitdir}/system.conf.d/53-cpuaccounting.conf

    # journald: Log to RAM, not storage
    install -m 0644 ${WORKDIR}/journald-storage.conf ${D}${systemd_unitdir}/journald.conf.d/50-storage.conf

    # journald: Set the maximium amount of memory for storing logs to 8M
    install -m 0644 ${WORKDIR}/journald-ram.conf ${D}${systemd_unitdir}/journald.conf.d/50-ram.conf

    # Keep relevant systemd data from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d

    # See SG-16046
    # Please review on upgrade to a newer systemd version
    rm ${D}${systemd_unitdir}/network/80-wired.network
    rmdir ${D}${systemd_unitdir}/network
}
