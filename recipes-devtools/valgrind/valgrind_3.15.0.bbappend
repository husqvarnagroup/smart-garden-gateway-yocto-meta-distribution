FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PR_append = ".0"

SRC_URI += "\
    file://0001-Add-support-for-syscall-epoll_create1.patch \
"
