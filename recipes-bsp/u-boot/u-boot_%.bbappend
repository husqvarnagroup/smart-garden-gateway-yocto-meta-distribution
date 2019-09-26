FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".5"

SRC_URI += "file://uEnv.txt"
