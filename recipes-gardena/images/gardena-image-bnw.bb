LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA for gateways using the BNW platform"

IMAGE_INSTALL += " \
    accessory-server \
    cloudadapter \
    coap-transport-proxy \
    fwrolloutd \
    gateway-config-backend \
    gateway-firmware \
    lemonbeatd \
    lwm2mserver \
    nngforward \
    os-release-bnw \
    ppp-network \
    ssh-authorized-keys-prod \
    sshtunnel \
    sshtunnel-check \
    swupdate-check \
    openssl-ossl-module-legacy \
"

inherit gardena-image-foss
