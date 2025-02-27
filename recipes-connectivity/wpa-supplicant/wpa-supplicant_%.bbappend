FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".10"

SRC_URI += " \
    file://keep.d/${BPN} \
"

SRC_URI:append = " \
    file://dbus/fi.w1.wpa_supplicant1.service \
    file://wpa_supplicant@.service \
"

FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${datadir}/dbus-1/system-services/fi.w1.wpa_supplicant1.service \
    ${systemd_unitdir}/system/dbus-fi.w1.wpa_supplicant1@.service \
    ${systemd_unitdir}/system/network-online.target.wants/wpa_supplicant@wlan0.service \
"

do_configure:append() {
    # Enable DBus Introspection
    echo "CONFIG_CTRL_IFACE_DBUS_INTRO=y" >> ${B}/wpa_supplicant/.config
}

do_install:append() {
    # Keep on updates
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d

    # Remove unneeded service files
    rm ${D}/${systemd_unitdir}/system/wpa_supplicant-nl80211@.service
    rm ${D}/${systemd_unitdir}/system/wpa_supplicant-wired@.service
    rm ${D}/${systemd_unitdir}/system/wpa_supplicant.service

    # Install customized unit
    install -m 644 ${WORKDIR}/wpa_supplicant@.service ${D}/${systemd_unitdir}/system/

    # Install D-Bus service
    install -m 644 ${WORKDIR}/dbus/fi.w1.wpa_supplicant1.service ${D}/${datadir}/dbus-1/system-services
    # Hack for D-Bus alias
    ln -s wpa_supplicant@.service ${D}/${systemd_unitdir}/system/dbus-fi.w1.wpa_supplicant1@.service

    # SG-17288 Avoid warning by HomeKit Accessory Server
    mkdir ${D}/${sysconfdir}/wpa_supplicant
    touch ${D}/${sysconfdir}/wpa_supplicant/wpa_supplicant-wlan0.conf
}

SYSTEMD_SERVICE:${PN} = "wpa_supplicant@.service wpa_supplicant@wlan0.service"
SYSTEMD_AUTO_ENABLE:${PN} = "disable"
