LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA image for gateways using the Seluxit platform"

IMAGE_INSTALL += " \
    openvpn-seluxit \
    ppp-network-seluxit \
    shadoway \
    ssh-authorized-keys-prod \
"

inherit gardena-image-proprietary
