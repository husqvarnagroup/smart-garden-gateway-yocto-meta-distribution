FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".6"

SRC_URI += " \
    file://keep.d/${BPN} \
"

SRC_URI_append = " \
    file://wpa_supplicant@.service \
"

FILES_${PN} += "\
    ${base_libdir}/upgrade/keep.d \
    ${systemd_unitdir}/system/network-online.target.wants/wpa_supplicant@wlan0.service \
"

do_install_append() {
    # Keep on updates
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${WORKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d

    # Remove unneeded service files
    rm ${D}/${systemd_unitdir}/system/wpa_supplicant-nl80211@.service
    rm ${D}/${systemd_unitdir}/system/wpa_supplicant-wired@.service
    rm ${D}/${systemd_unitdir}/system/wpa_supplicant.service

    # Install customized unit
    install -m 644 ${WORKDIR}/wpa_supplicant@.service ${D}/${systemd_unitdir}/system/
}

SYSTEMD_SERVICE_${PN} = "wpa_supplicant@.service wpa_supplicant@wlan0.service"
SYSTEMD_AUTO_ENABLE_${PN} = "disable"
