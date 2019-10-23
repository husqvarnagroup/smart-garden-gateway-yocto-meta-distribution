FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".1"

SRC_URI += " \
    file://0001-ubi-provide-a-way-to-skip-CRC-checks.patch \
    file://0002-ubi-Print-skip_check-in-ubi_dump_vol_info.patch \
    file://0003-ubi-Add-skipcheck-command-to-set-clear-this-bit-in-t.patch \
    file://0004-WIP-include-configs-gardena-smart-gateway-at91sam.h-.patch \
    file://0005-arm-at91-gardena-smart-gateway-at91sam-Fix-mtdpart-d.patch \
    file://0006-arm-at91-gardena-smart-gateway-at91sam-Fix-environme.patch \
    file://0007-arm-at91-gardena-smart-gateway-at91sam-Set-default-b.patch \
    file://0008-mips-mt76xx-gardena-smart-gateway-Set-default-bootde.patch \
    file://0009-mips-mt76xx-gardena-smart-gateway-Enable-UBI-fastmap.patch \
    file://0010-arm-at91-gardena-smart-gateway-at91sam-Enable-UBI-fa.patch \
"

