FILESEXTRAPATHS:prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/${PN}:"

PR:append = ".0"

UBOOT_LOCALVERSION = "-gardena-0"
PV:append = "${UBOOT_LOCALVERSION}"

SRC_URI += " \
    file://uEnv.txt \
    file://0001-bootcount-Allow-boot-counter-to-be-enabled-for-AT91S.patch \
    file://0002-arm-at91-gardena-smart-gateway-at91sam-Enable-boot-c.patch \
    file://0003-timers-atmel_pit-Add-early-timer-support.patch \
    file://0004-arm-at91-gardena-smart-gateway-at91sam-Fix-udelay-in.patch \
    file://0005-Revert-spl-nor-Don-t-allocate-header-on-stack.patch \
    file://0006-mips-mt7688-gardena-smart-gateway-Use-DM-API-for-fla.patch \
    file://distro.cfg \
"

do_deploy:append:at91sam9x5() {
    # There will be no files with whitespaces
    for f in u-boot*; do
        sha256sum "$f" | awk '{print $1}' > "$f.sha256"
    done
}
