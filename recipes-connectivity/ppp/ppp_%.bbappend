FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".6"

SRC_URI += "file://ppp.service \
            file://ppp0.network \
"

do_install_append() {
    install -m 0644 ${WORKDIR}/ppp.service ${D}${systemd_unitdir}/system

    install -d 0755 ${D}${systemd_unitdir}/network
    install -m 0644 ${WORKDIR}/ppp0.network ${D}${systemd_unitdir}/network

    sed -i -e 's,@SBINDIR@,${sbindir},g' \
        -e 's,@TTY@,${RADIO_MODULE_PPP_TTY},g' \
        ${D}${systemd_unitdir}/system/ppp.service
}

FILES_${PN} += "\
    ${systemd_unitdir}/network \
"

SYSTEMD_SERVICE_${PN} = "ppp.service"

RDEPENDS_${PN} += " \
    gateway-firmware \
"
