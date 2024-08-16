LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA manufacturing image"

COMPATIBLE_MACHINE = "gardena-sg-mt7688"

IMAGE_INSTALL += " \
    accessory-server-factory \
    gateway-config-backend \
    gateway-firmware-zephyr \
    manufacturing-tools \
    os-release-factory \
    rm-test-firmware \
    ssh-authorized-keys-prod \
    sshtunnel \
    sshtunnel-timer \
    swupdate-check \
    swupdate-legacy \
"

inherit gardena-image-base
