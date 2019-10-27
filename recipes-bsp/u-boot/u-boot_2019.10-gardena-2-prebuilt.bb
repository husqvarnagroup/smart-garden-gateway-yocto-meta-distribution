COMPATIBLE_MACHINE = "mt7688"

require recipes-bsp/u-boot/u-boot-prebuilt.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files/${PN}-${PV}:"

SRC_URI += " \
    file://uEnv.txt \
"
PR = "${INC_PR}.0"
