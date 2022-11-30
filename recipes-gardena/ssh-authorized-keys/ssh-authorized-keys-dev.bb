SUMMARY = "SSH pub keys of GARDENA developers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PV = "0.9"

SRC_URI = " \
    file://adrian-friedli.pub \
    file://agash-thamo.pub \
    file://alexey-nezhdanov.pub \
    file://andreas-müller.pub \
    file://andreas_boerrnert.pub \
    file://andreas-koeppel.pub \
    file://boris-ruch.pub \
    file://christoph-schnetzler.pub \
    file://cornel-bruelisauer.pub \
    file://dusan-markovic.pub \
    file://ezra-buehler.pub \
    file://fabian-frei.pub \
    file://felix-bruelisauer.pub \
    file://florian-schweikert.pub \
    file://gerald-reisinger.pub \
    file://jessica-eichberg.pub \
    file://low-cost-gateway-prod.pub \
    file://manuel-knobel.pub \
    file://marc-lasch.pub \
    file://marcel-mueller.pub \
    file://markus-gruber.pub \
    file://michel-werren.pub \
    file://nicola-ochsenbein.pub \
    file://pascal-brogle.pub \
    file://peter-penkalla.pub \
    file://peter-tonz.pub \
    file://renato-staehli.pub \
    file://reto-schneider_homeoffice.pub \
    file://reto-schneider_office.pub \
    file://sandro-klarer.pub \
    file://sebastian-schoch.pub \
    file://sshportal-dev.pub \
    file://timon-braendli.pub \
    file://tobias-greuter.pub \
"

inherit ssh-authorized-keys
