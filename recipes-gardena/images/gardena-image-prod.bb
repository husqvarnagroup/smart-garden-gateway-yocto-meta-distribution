LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "The Gardena image for usage on productive gateways"

IMAGE_INSTALL += " \
    ssh-authorized-keys-prod \
"

inherit gardena-image
