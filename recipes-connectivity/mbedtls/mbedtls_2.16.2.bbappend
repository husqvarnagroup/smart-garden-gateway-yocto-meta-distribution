FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"

PR_append = ".0"

SRC_URI += " \
    file://0001-bn_mul.h-disable-MULADDC-code-for-cpu-before-armv6.patch \
"
