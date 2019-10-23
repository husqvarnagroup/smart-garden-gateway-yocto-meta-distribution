FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".6"

SRC_URI += " \
    file://uEnv.txt \
"
