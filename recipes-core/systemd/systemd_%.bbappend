FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://credit-random-seed.conf \
    file://keep.d/${BPN} \
    file://serial-getty@ttyS0.service_override.conf \
    file://systemd-disable-colors.sh \
    file://systemd-disable-pager.sh \
    file://systemd-networkd-wait-online.service \
    file://99-default.link \
    file://99-husqvarna-default.conf \
"

FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${sysconfdir}/profile.d/systemd-disable-colors.sh \
    ${sysconfdir}/profile.d/systemd-disable-pager.sh \
    ${systemd_unitdir}/system/systemd-random-seed.service.d \
"

PR:append = ".2"

do_install:append() {
    # Disable colorized output of system tools (systemctl, etc.)
    install -d ${D}${sysconfdir}/profile.d
    install -m 0644 ${WORKDIR}/systemd-disable-colors.sh ${D}${sysconfdir}/profile.d
    install -m 0644 ${WORKDIR}/systemd-disable-pager.sh ${D}${sysconfdir}/profile.d

    # Trust our random seed, credit it
    install -d ${D}${systemd_unitdir}/system/systemd-random-seed.service.d
    install -m 0644 ${WORKDIR}/credit-random-seed.conf ${D}${systemd_unitdir}/system/systemd-random-seed.service.d

    # Always append our own NTP server names as a default (99- takes a very low precedence)
    install -d ${D}${sysconfdir}/systemd/timesyncd.conf.d
    install -m 0644 ${WORKDIR}/99-husqvarna-default.conf ${D}${sysconfdir}/systemd/timesyncd.conf.d

    # Override systemd-networkd-wait-online.service to remove it from network-online.target.wants
    install -d ${D}${sysconfdir}/systemd/system
    install -m 0644 ${WORKDIR}/systemd-networkd-wait-online.service ${D}${sysconfdir}/systemd/system

    # Override serial-getty@ttyS0.service to add (re)start limit
    install -d ${D}${sysconfdir}/systemd/system/serial-getty@ttyS0.service.d
    install -m 0644 ${WORKDIR}/serial-getty@ttyS0.service_override.conf \
        ${D}${sysconfdir}/systemd/system/serial-getty@ttyS0.service.d/override.conf

    # Keep relevant systemd data from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d

    # Override to prevent network interfaces from being renamed
    install -d ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/99-default.link ${D}${sysconfdir}/systemd/network
}

PACKAGECONFIG:remove = " \
    backlight \
    binfmt \
    gshadow \
    hibernate \
    hostnamed \
    idn \
    ima \
    localed \
    logind \
    machined \
    myhostname \
    nss \
    nss-mymachines \
    nss-resolve \
    quotacheck \
    resolved \
    sysusers \
    sysvinit \
    timesyncd \
    userdb \
    utmp \
    vconsole \
    wheel-group \
"
