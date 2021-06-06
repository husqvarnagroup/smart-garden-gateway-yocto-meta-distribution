FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/${PN}:"

PR_append = ".3"

UBOOT_LOCALVERSION = "-gardena-2"
PV_append = "${UBOOT_LOCALVERSION}"

SRC_URI += " \
    file://uEnv.txt \
"

SRC_URI_append = " \
    file://0001-mtd-spi-nor-ids-Add-XMC-XM25QH64C-flash.patch \
    file://0002-arm-at91-gardena-smart-gateway-at91sam-Adjust-with-p.patch \
    file://0003-mtd-nand-spi-Only-one-dummy-byte-in-QUADIO.patch \
    file://0004-mtd-nand-spi-Support-GigaDevice-GD5F1GQ5UExxG.patch \
"

do_deploy_append_at91sam9x5() {
    # There will be no files with whitespaces
    for f in u-boot*; do
        sha256sum "$f" | awk '{print $1}' > "$f.sha256"
    done
}
