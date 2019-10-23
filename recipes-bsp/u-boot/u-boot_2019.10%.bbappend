FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".0"

# Changing UBOOT_LOCALVERSION *and* the PV so that PREFERRED_VERSION_u-boot and
# PV of the u-boot package match. We need this to generate a sw-description
# file which checks for the same version string as the one which is compiled
# into the U-Boot binary.
# Changing UBOOT_LOCALVERSION causes the (new) U-Boot binary to be flashed by
# SWUpdate. Use with caution!
UBOOT_LOCALVERSION = "-gardena-1"
PV_append = "${UBOOT_LOCALVERSION}"

SRC_URI += " \
    file://0001-ubi-provide-a-way-to-skip-CRC-checks.patch \
    file://0002-ubi-Print-skip_check-in-ubi_dump_vol_info.patch \
    file://0003-ubi-Add-skipcheck-command-to-set-clear-this-bit-in-t.patch \
    file://0004-WIP-include-configs-gardena-smart-gateway-at91sam.h-.patch \
    file://0005-arm-at91-gardena-smart-gateway-at91sam-Fix-mtdpart-d.patch \
    file://0006-arm-at91-gardena-smart-gateway-at91sam-Align-volume-.patch \
    file://0007-arm-at91-gardena-smart-gateway-at91sam-Set-default-b.patch \
    file://0008-mips-mt76xx-gardena-smart-gateway-Set-default-bootde.patch \
    file://0009-mips-mt76xx-gardena-smart-gateway-Enable-UBI-fastmap.patch \
    file://0010-arm-at91-gardena-smart-gateway-at91sam-Enable-UBI-fa.patch \
"

