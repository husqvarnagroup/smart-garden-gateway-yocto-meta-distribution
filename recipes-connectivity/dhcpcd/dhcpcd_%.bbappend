FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PR:append = ".9"

# dhcpcd 10.3.1 receives no events from its udev monitor, and while a dev
# plugin is loaded it does not announce new interfaces from netlink either
# (src/if-linux.c). An interface showing up after dhcpcd has started, such as
# wlan0, is then never configured. Without the plugin, netlink is used again.
PACKAGECONFIG:remove = "udev"

SRC_URI += " \
    file://40-swupdate-check.sh \
    file://50-chronyd \
    file://dhcpcd.conf \
    file://keep.d/${BPN} \
"

FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${UNPACKDIR}/dhcpcd.conf ${D}${sysconfdir}/dhcpcd.conf

    install -d ${D}${libexecdir}/dhcpcd-hooks
    install -m 0644 ${UNPACKDIR}/40-swupdate-check.sh ${D}${libexecdir}/dhcpcd-hooks/40-swupdate-check
    install -m 0644 ${UNPACKDIR}/50-chronyd ${D}${libexecdir}/dhcpcd-hooks/50-chronyd

    # Keep DHCP Unique Identifier on updates
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${UNPACKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
