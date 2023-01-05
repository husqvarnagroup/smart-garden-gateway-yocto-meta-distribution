LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA manufacturing image"

IMAGE_INSTALL += " \
    openvpn-factory \
    ppp-network \
    ssh-authorized-keys-prod \
"

IMAGE_INSTALL_remove = " \
    healthcheck \
    rsyslog \
    tcpdump-sherlock-ppp0 \
    tcpdump-sherlock-vpn0 \
"

inherit gardena-image-proprietary
