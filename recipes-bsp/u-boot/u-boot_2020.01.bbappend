FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".2"

UBOOT_LOCALVERSION = "-gardena-1"
PV_append = "${UBOOT_LOCALVERSION}"

SRC_URI += " \
    file://uEnv.txt \
"

SRC_URI_append_at91sam9x5 = " \
    file://0001-arm-at91-gardena-smart-gateway-at91sam-Adjust-with-p.patch \
"

do_deploy_append_at91sam9x5() {
    # There will be no files with whitespaces
    for f in u-boot*; do
        sha256sum "$f" | awk '{print $1}' > "$f.sha256"
    done
}
