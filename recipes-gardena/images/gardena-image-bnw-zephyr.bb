LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA image for Zephyr based RM firmwares"

IMAGE_INSTALL += " \
    accessory-server \
    cloudadapter \
    coap-transport-proxy \
    fwrolloutd \
    gateway-config-backend \
    gateway-firmware-zephyr \
    lemonbeatd \
    lwm2mserver \
    metrics \
    nngforward \
    os-release-bnw-zephyr \
    ssh-authorized-keys-prod \
    sshtunnel \
    sshtunnel-check \
    swupdate-legacy \
    swupdate-check \
"

inherit gardena-image-foss
