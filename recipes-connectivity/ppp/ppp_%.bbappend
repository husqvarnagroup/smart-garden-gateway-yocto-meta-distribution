FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".4"

SRC_URI += "file://ppp.service \
            file://ipv6-up \
            file://ipv6-down \
            file://01_set_routes \
"

do_install_append() {
    mkdir -p ${D}${sysconfdir}/ppp/ipv6-up.d/
    mkdir -p ${D}${sysconfdir}/ppp/ipv6-down.d/
    install -m 0755 ${WORKDIR}/ipv6-up ${D}${sysconfdir}/ppp/
    install -m 0755 ${WORKDIR}/ipv6-down ${D}${sysconfdir}/ppp/
    install -m 0755 ${WORKDIR}/01_set_routes ${D}${sysconfdir}/ppp/ipv6-up.d/
    install -m 0644 ${WORKDIR}/ppp.service ${D}${systemd_unitdir}/system
    sed -i -e 's,@SBINDIR@,${sbindir},g' \
	       -e 's,@TTY@,${RADIO_MODULE_PPP_TTY},g' \
	       ${D}${systemd_unitdir}/system/ppp.service
}

SYSTEMD_SERVICE_${PN} = "ppp.service"

RDEPENDS_${PN} += " \
    gateway-firmware \
"
