PR:append = ".0"

require meta-distribution-linux-common.inc
require linux-version-extension-common.inc

unset COMPATIBLE_MACHINE

FILESEXTRAPATHS:prepend := "${THISDIR}:${THISDIR}/${BPN}-${LINUX_VERSION}:"

SRC_URI += " \
    file://defconfig \
    file://0001-clk-ralink-mtmips-add-mmc-related-clocks-for-SoCs-MT.patch \
    file://0002-dt-bindings-clock-add-clock-definitions-for-Ralink-S.patch \
    file://0003-mips-dts-ralink-mt7628a-update-system-controller-nod.patch \
    file://0004-MIPS-dts-ralink-mt7628a-Fix-sysc-s-compatible-proper.patch \
    file://0005-MIPS-dts-ralink-mt7628a-Update-watchdog-node-accordi.patch \
    file://0006-MIPS-dts-ralink-gardena_smart_gateway_mt7688-Fix-pow.patch \
    file://0007-ARM-dts-microchip-gardena-smart-gateway-Fix-power-LE.patch \
    file://0008-drivers-misc-add-U-Boot-bootcount-driver-enhanced-ve.patch \
    file://0009-net-ethernet-ralink-Import-switch-driver-from-OpenWr.patch \
    file://0010-net-ethernet-ralink-Fix-for-newer-Linux-versions.patch \
    file://0011-net-ethernet-ralink-mtk_eth_soc-Set-DMA-masks.patch \
    file://0012-net-swconfig-adds-openwrt-switch-layer.patch \
    file://0013-MIPS-ralink-mt7628a.dtsi-Add-ethernet-and-ESW-nodes.patch \
    file://0014-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-eth.patch \
    file://0015-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-boo.patch \
    file://0016-ARM-dts-microchip-gardena-smart-gateway-Add-bootcoun.patch \
    file://0017-tty-serial-8250-Call-serial8250_enable_ms-from-seria.patch \
    file://0018-gpio-mt7621-Assign-base-field-in-gpio_chip.patch \
    file://0019-rtl8xxxu-Add-debugfs-entries-for-registers.patch \
    file://0020-rtl8xxxu-Handle-BSS_CHANGED_TXPOWER-IEEE80211_CONF_C.patch \
    file://0021-rtl8xxxu-Handle-mac80211-get_txpower.patch \
    file://0022-rtl8xxxu-Enable-RX-STBC-by-default.patch \
    file://0023-rtl8xxxu-Fix-reported-RX-signal-strength.patch \
    file://0024-rtl8xxxu-Raise-error-level-of-IQK-failures.patch \
"
