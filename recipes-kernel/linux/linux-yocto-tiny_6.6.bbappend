hPR:append = ".0"

require meta-distribution-linux-common.inc
require linux-version-extension-common.inc

unset COMPATIBLE_MACHINE

FILESEXTRAPATHS:prepend := "${THISDIR}:${THISDIR}/${BPN}-${LINUX_VERSION}:"

SRC_URI += " \
    file://defconfig \
    file://0001-ARM-dts-microchip-at91sam9x5ek-Use-DMA-for-DBGU-seri.patch \
    file://0002-ARM-dts-microchip-gardena-smart-gateway-Use-DMA-for-.patch \
    file://0003-drivers-misc-add-U-Boot-bootcount-driver-enhanced-ve.patch \
    file://0004-net-ethernet-ralink-Import-switch-driver-from-OpenWr.patch \
    file://0005-net-ethernet-ralink-Replace-ethtool_puts-with-memcpy.patch \
    file://0006-net-ethernet-ralink-mtk_eth_soc-Set-DMA-masks.patch \
    file://0007-net-swconfig-adds-openwrt-switch-layer.patch \
    file://0008-MIPS-ralink-mt7628a.dtsi-Add-ethernet-and-ESW-nodes.patch \
    file://0009-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-eth.patch \
    file://0010-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Add-boo.patch \
    file://0011-ARM-dts-microchip-gardena-smart-gateway-Add-bootcoun.patch \
    file://0012-tty-serial-8250-Call-serial8250_enable_ms-from-seria.patch \
    file://0013-gpio-mt7621-Assign-base-field-in-gpio_chip.patch \
    file://0014-MIPS-dts-ralink-mt7628a-Fix-sysc-compatible-string.patch \
    file://0015-MIPS-dts-ralink-mt7628a-Adapt-to-new-clock-reset-dri.patch \
    file://0016-MIPS-dts-ralink-mt7628a-Adapt-to-latest-watchdog-dri.patch \
    file://0017-rtl8xxxu-Add-debugfs-entries-for-registers.patch \
    file://0018-rtl8xxxu-Handle-BSS_CHANGED_TXPOWER-IEEE80211_CONF_C.patch \
    file://0019-rtl8xxxu-Handle-mac80211-get_txpower.patch \
    file://0020-rtl8xxxu-Enable-RX-STBC-by-default.patch \
    file://0021-rtl8xxxu-Fix-reported-RX-signal-strength.patch \
    file://0022-rtl8xxxu-Raise-error-level-of-IQK-failures.patch \
    file://0023-MIPS-ralink-dts-gardena_smart_gateway_mt7688-Fix-pow.patch \
    file://0024-ARM-dts-microchip-gardena-smart-gateway-Fix-power-LE.patch \
    file://0025-wifi-rtl8xxxu-remove-assignment-of-priv-vif-in-rtl8x.patch \
    file://0026-wifi-rtl8xxxu-prepare-supporting-two-virtual-interfa.patch \
    file://0027-wifi-rtl8xxxu-support-setting-linktype-for-both-inte.patch \
    file://0028-wifi-rtl8xxxu-8188e-convert-usage-of-priv-vif-to-pri.patch \
    file://0029-wifi-rtl8xxxu-support-setting-mac-address-register-f.patch \
    file://0030-wifi-rtl8xxxu-extend-wifi-connected-check-to-both-in.patch \
    file://0031-wifi-rtl8xxxu-extend-check-for-matching-bssid-to-bot.patch \
    file://0032-wifi-rtl8xxxu-don-t-parse-CFO-if-both-interfaces-are.patch \
    file://0033-wifi-rtl8xxxu-support-setting-bssid-register-for-mul.patch \
    file://0034-wifi-rtl8xxxu-support-multiple-interfaces-in-set_aif.patch \
    file://0035-wifi-rtl8xxxu-support-multiple-interfaces-in-update_.patch \
    file://0036-wifi-rtl8xxxu-support-multiple-interfaces-in-configu.patch \
    file://0037-wifi-rtl8xxxu-support-multiple-interfaces-in-watchdo.patch \
    file://0038-wifi-rtl8xxxu-support-multiple-interfaces-in-add-rem.patch \
    file://0039-wifi-rtl8xxxu-support-multiple-interfaces-in-bss_inf.patch \
    file://0040-wifi-rtl8xxxu-support-multiple-interface-in-start_ap.patch \
    file://0041-wifi-rtl8xxxu-add-macids-for-STA-mode.patch \
    file://0042-wifi-rtl8xxxu-remove-obsolete-priv-vif.patch \
    file://0043-wifi-rtl8xxxu-add-hw-crypto-support-for-AP-mode.patch \
    file://0044-wifi-rtl8xxxu-make-supporting-AP-mode-only-on-port-0.patch \
    file://0045-wifi-rtl8xxxu-Fix-off-by-one-initial-RTS-rate.patch \
    file://0046-wifi-rtl8xxxu-convert-EN_DESC_ID-of-TX-descriptor-to.patch \
    file://0047-wifi-rtl8xxxu-add-missing-number-of-sec-cam-entries-.patch \
    file://0048-wifi-rtl8xxxu-update-rate-mask-per-sta.patch \
    file://0049-wifi-rtl8xxxu-check-vif-before-using-in-rtl8xxxu_tx.patch \
    file://0050-wifi-rtl8xxxu-Add-separate-MAC-init-table-for-RTL819.patch \
    file://0051-wifi-rtl8xxxu-Enable-AP-mode-for-RTL8192CU-RTL8188CU.patch \
    file://0052-wifi-rtl8xxxu-Use-macid-in-rtl8xxxu_update_rate_mask.patch \
    file://0053-wifi-rtl8xxxu-Use-macid-in-rtl8xxxu_fill_txdesc_v1.patch \
    file://0054-wifi-rtl8xxxu-Make-sure-TX-rate-is-reported-in-AP-mo.patch \
"
