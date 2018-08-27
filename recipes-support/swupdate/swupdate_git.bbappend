FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://disable_webserver.cfg \
    file://enable_download.cfg \
    file://enable_sha256.cfg \
    file://enable_systemd.cfg \
    file://enable_ubi.cfg \
"

DEPENDS += "systemd curl"
