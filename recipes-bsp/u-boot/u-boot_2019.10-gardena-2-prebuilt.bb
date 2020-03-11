require recipes-bsp/u-boot/u-boot-prebuilt.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files/${PN}-${PV}:"

UBOOT_BINARY_at91sam9x5 = "u-boot-with-spl.bin-gardena-sg-at91sam"

SRC_URI += " \
    file://uEnv.txt \
"
PR = "${INC_PR}.1"
