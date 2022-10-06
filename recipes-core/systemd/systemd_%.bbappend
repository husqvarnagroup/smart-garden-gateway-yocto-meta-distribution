FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://credit-random-seed.conf \
    file://keep.d/${BPN} \
    file://systemd-disable-colors.sh \
    file://systemd-disable-pager.sh \
    file://99-husqvarna-default.conf \
"

FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${sysconfdir}/profile.d/systemd-disable-colors.sh \
    ${sysconfdir}/profile.d/systemd-disable-pager.sh \
    ${systemd_unitdir}/system/systemd-random-seed.service.d \
"

PR:append = ".0"

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

    # Keep relevant systemd data from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
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
    userdb \
    utmp \
    vconsole \
    wheel-group \
"
