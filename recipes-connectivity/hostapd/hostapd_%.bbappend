FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".0"

SRC_URI_append = " \
    file://hostapd-genconf.sh \
    file://hostapd@.service \
"

do_install_append() {
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/hostapd-genconf.sh ${D}${bindir}/hostapd-genconf

    rm ${D}${systemd_unitdir}/system/hostapd.service
    install -m 0644 ${WORKDIR}/hostapd@.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE_${PN} = "hostapd@.service"