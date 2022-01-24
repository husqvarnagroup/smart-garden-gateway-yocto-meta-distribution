LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA image for usage on LONA gateways"

IMAGE_INSTALL += " \
    gateway-firmware \
    openvpn-seluxit \
    ppp-network-seluxit \
    shadoway-lona \
    ssh-authorized-keys-dev \
"

inherit gardena-image-proprietary
