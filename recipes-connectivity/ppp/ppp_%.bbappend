FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".10"

SRC_URI += " \
    file://ppp-failure.service \
    file://ppp.service \
"

FILES:${PN} += "${systemd_unitdir}/system/ppp-failure.service"

do_install:append() {
    install -m 0644 ${WORKDIR}/ppp.service ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/ppp-failure.service ${D}${systemd_unitdir}/system

    sed -i -e 's,@SBINDIR@,${sbindir},g' \
        -e 's,@TTY@,${RADIO_MODULE_PPP_TTY},g' \
        ${D}${systemd_unitdir}/system/ppp.service
}

SYSTEMD_SERVICE:${PN} = "ppp.service"

RDEPENDS:${PN} += " \
    gateway-firmware \
"
