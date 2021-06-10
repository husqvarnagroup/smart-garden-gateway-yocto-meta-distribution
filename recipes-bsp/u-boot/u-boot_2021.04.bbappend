FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/${PN}:"

PR_append = ".0"

UBOOT_LOCALVERSION = "-gardena-6"
PV_append = "${UBOOT_LOCALVERSION}"

SRC_URI += " \
    file://uEnv.txt \
    file://0001-mtd-spi-nor-ids-Add-XMC-XM25QH64C-flash.patch \
    file://0002-arm-at91-gardena-smart-gateway-at91sam-Adjust-to-pro.patch \
    file://0003-Revert-time-Fix-get_ticks-being-non-monotonic.patch \
    file://0004-mips-mt76xx-gardena-smart-gateway-Increase-CONFIG_SP.patch \
    file://distro.cfg \
"

do_deploy_append_at91sam9x5() {
    # There will be no files with whitespaces
    for f in u-boot*; do
        sha256sum "$f" | awk '{print $1}' > "$f.sha256"
    done
}
