SUMMARY = "SSH pub keys of GARDENA developers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PV = "0.2"

SRC_URI = " \
    file://andreas-müller.pub \
    file://reto-schneider_homeoffice.pub \
    file://reto-schneider_office.pub \
    file://andrej-gessel.pub \
"

inherit ssh-authorized-keys
