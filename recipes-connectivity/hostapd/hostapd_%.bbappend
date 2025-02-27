FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".4"

SRC_URI:append = " \
    file://hostapd-genconf.sh \
    file://hostapd@.service \
"

do_install:append() {
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/hostapd-genconf.sh ${D}${bindir}/hostapd-genconf

    rm ${D}${systemd_unitdir}/system/hostapd.service
    install -m 0644 ${WORKDIR}/hostapd@.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE:${PN} = "hostapd@.service"
