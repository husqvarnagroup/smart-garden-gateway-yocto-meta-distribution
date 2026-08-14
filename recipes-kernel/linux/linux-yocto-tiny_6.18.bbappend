PR:append = ".0"

require meta-distribution-linux-common.inc
require linux-version-extension-common.inc

unset COMPATIBLE_MACHINE

FILESEXTRAPATHS:prepend := "${THISDIR}:${THISDIR}/${BPN}-${LINUX_VERSION}:"

SRC_URI += " \
    file://defconfig \
    file://0001-drivers-misc-add-U-Boot-bootcount-driver-enhanced-ve.patch \
    file://0002-net-ethernet-ralink-Import-switch-driver-from-OpenWr.patch \
    file://0003-net-ethernet-ralink-Fix-for-newer-Linux-versions.patch \
    file://0004-net-ethernet-ralink-mtk_eth_soc-Set-DMA-masks.patch \
    file://0005-net-swconfig-adds-openwrt-switch-layer.patch \
    file://0006-MIPS-ralink-mt7628a.dtsi-Add-ethernet-and-ESW-nodes.patch \
    file://0007-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-eth.patch \
    file://0008-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-boo.patch \
    file://0009-ARM-dts-microchip-gardena-smart-gateway-Add-bootcoun.patch \
    file://0010-tty-serial-8250-Call-serial8250_enable_ms-from-seria.patch \
    file://0011-rtl8xxxu-Handle-BSS_CHANGED_TXPOWER-IEEE80211_CONF_C.patch \
    file://0012-rtl8xxxu-Handle-mac80211-get_txpower.patch \
    file://0013-rtl8xxxu-Enable-RX-STBC-by-default.patch \
    file://0014-rtl8xxxu-Fix-reported-RX-signal-strength.patch \
    file://0015-rtl8xxxu-Raise-error-level-of-IQK-failures.patch \
    file://0016-mtd-spinand-Restore-read-throughput-on-slow-SoCs.patch \
"

# FIXME: https://lists.yoctoproject.org/g/linux-yocto/topic/linux_kernel_tools/115767170
do_kernel_configcheck[noexec] = "1"
