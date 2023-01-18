FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".2"

SRC_URI_append = " \
    file://dnsmasq@.service \
    file://dnsmasq.d/wlan0/gardena.conf \
"

do_install_append() {
    rm ${D}/${systemd_unitdir}/system/dnsmasq.service
    install -m 644 ${WORKDIR}/dnsmasq@.service ${D}/${systemd_unitdir}/system/

    install -d ${D}${sysconfdir}/dnsmasq.d/wlan0
    install -m 644 ${WORKDIR}/dnsmasq.d/wlan0/gardena.conf ${D}${sysconfdir}/dnsmasq.d/wlan0/
}

SYSTEMD_SERVICE_${PN} = "dnsmasq@.service"

# Disable autostart of default dnsmasq service
SYSTEMD_AUTO_ENABLE = "disable"
