SUMMARY = "SSH pub keys granting access to manufactured devices"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PV = "0.3"

SRC_URI = " \
    file://sshportal-dev.pub \
"

inherit ssh-authorized-keys
