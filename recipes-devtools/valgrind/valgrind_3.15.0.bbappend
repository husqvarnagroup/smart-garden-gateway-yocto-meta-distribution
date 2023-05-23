FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".0"

SRC_URI += "\
    file://0001-Add-support-for-syscall-epoll_create1.patch \
"
