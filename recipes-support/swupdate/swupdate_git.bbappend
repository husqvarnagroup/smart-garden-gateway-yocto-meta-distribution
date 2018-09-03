FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = 'dfd1dbd764d02e7f2b1de586517b9c8f6210e14f'

SRC_URI += " \
    file://disable_webserver.cfg \
    file://enable_download.cfg \
    file://enable_sha256.cfg \
    file://enable_systemd.cfg \
    file://enable_ubi.cfg \
"

DEPENDS += "systemd curl"
