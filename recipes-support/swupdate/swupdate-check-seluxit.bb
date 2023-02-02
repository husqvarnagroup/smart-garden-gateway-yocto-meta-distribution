require swupdate-check.inc

PR = "${INC_PR}.2"

DISTRO_UPDATE_URL = "${DISTRO_UPDATE_URL_BASE}/gardena-update-image-prod-${MACHINE}.swu"

RDEPENDS:${PN}:append = " \
    busybox \
"
