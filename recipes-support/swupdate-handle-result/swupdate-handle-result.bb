DESCRIPTION = "swupdate-handle-result"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "1.0"
PR = "r0"

SRC_URI = "\
    file://swupdate-handle-result.c \
"

S = "${WORKDIR}/"

inherit pkgconfig

DEPENDS += "systemd"
PACKAGECONFIG ?= "systemd"

do_compile() {
    ${CC} \
        ${CFLAGS} \
        ${LDFLAGS} \
        -o swupdate-handle-result \
        -Wall \
        -Wextra \
        -Wpedantic \
        -Werror \
        ${WORKDIR}/swupdate-handle-result.c \
        $(pkg-config --libs --cflags libsystemd)
}

do_install() {
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/swupdate-handle-result ${D}${bindir}/
}
