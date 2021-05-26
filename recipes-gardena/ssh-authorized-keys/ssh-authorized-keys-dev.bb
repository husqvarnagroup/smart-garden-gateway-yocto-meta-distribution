SUMMARY = "SSH pub keys of GARDENA developers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PV = "0.3"

SRC_URI = " \
    file://andreas-müller.pub \
    file://andrej-gessel.pub \
    file://gerald-reisinger.pub \
    file://low-cost-gateway-prod.pub \
    file://marc-lasch.pub \
    file://marcel.mueller@husqvarnagroup.com \
    file://pascal-brogle.pub \
    file://reto-schneider_homeoffice.pub \
    file://reto-schneider_office.pub \
    file://timon-braendli.pub \
"

inherit ssh-authorized-keys
