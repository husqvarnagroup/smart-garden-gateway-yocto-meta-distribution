PR:append = ".0"

require meta-distribution-linux-common.inc
require linux-version-extension-common.inc

unset COMPATIBLE_MACHINE

FILESEXTRAPATHS:prepend := "${THISDIR}:${THISDIR}/${BPN}-${LINUX_VERSION}:"

SRC_URI += " \
    file://defconfig \
    file://0001-drivers-misc-add-U-Boot-bootcount-driver-enhanced-ve.patch \
    file://0002-Import-OpenWRT-Ethernet-switch-drivers.patch \
    file://0003-net-swconfig-adds-openwrt-switch-layer.patch \
    file://0004-net-ethernet-ralink-mtk_eth_soc-Set-DMA-masks.patch \
    file://0005-net-ethernet-ralink-rt3050-fix-carrier.patch \
    file://0006-MIPS-ralink-mt7628a.dtsi-Add-ethernet-and-ESW-nodes.patch \
    file://0007-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-eth.patch \
    file://0008-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-boo.patch \
    file://0009-tty-serial-8250-Call-serial8250_enable_ms-from-seria.patch \
    file://0010-gpio-mt7621-Assign-base-field-in-gpio_chip.patch \
    file://0011-mtd-spi-nor-Add-support-for-XM25QH64C.patch \
    file://0012-mtd-spinand-gigadevice-Support-GD5F1GQ5UExxG.patch \
    file://0013-rtlwifi-Use-mac80211-debugfs-location.patch \
    file://0014-rtlwifi-Add-debugfs-entries-for-registers.patch \
    file://0015-rtl8xxxu-Add-debugfs-entries-for-registers.patch \
    file://0016-rtl8xxxu-Simplify-locking-of-a-skb-list-accesses.patch \
    file://0017-rtl8xxxu-avoid-parsing-short-RX-packet.patch \
    file://0018-rtl8xxxu-disable-interrupt_in-transfer-for-8188cu-an.patch \
    file://0019-rtl8xxxu-Use-lower-tx-rates-for-the-ack-packet.patch \
    file://0020-rtl8xxxu-Handle-BSS_CHANGED_TXPOWER-IEEE80211_CONF_C.patch \
    file://0021-rtl8xxxu-Handle-mac80211-get_txpower.patch \
    file://0022-rtl8xxxu-Enable-RX-STBC-by-default.patch \
    file://0023-rtl8xxxu-Feed-antenna-information-for-mac80211.patch \
    file://0024-rtl8xxxu-Fill-up-txrate-info-for-all-chips.patch \
    file://0025-rtl8xxxu-Fix-reported-RX-signal-strength.patch \
    file://0026-rtl8xxxu-Raise-error-level-of-IQK-failures.patch \
    file://0027-ARM-dts-at91-at91sam9x5ek-Use-DMA-for-DBGU-serial-po.patch \
    file://0028-ARM-dts-at91-gardena-smart-gateway-Use-DMA-for-USART.patch \
"
