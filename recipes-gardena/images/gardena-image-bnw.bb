LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The GARDENA for gateways using the BNW platform"

IMAGE_INSTALL += " \
    accessory-server \
    cloudadapter \
    fwrolloutd \
    gateway-config-backend \
    lemonbeatd \
    lwm2mserver \
    nngforward \
    ppp-network \
    ssh-authorized-keys-prod \
    sshtunnel \
    swupdate-check \
"

inherit gardena-image-proprietary
