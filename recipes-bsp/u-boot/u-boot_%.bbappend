FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".1"

SRC_URI += " \
    file://uEnv.txt \
"

do_deploy_append_at91sam9x5() {
    # There will be no files with whitespaces
    for f in u-boot*; do
        sha256sum "$f" | awk '{print $1}' > "$f.sha256"
    done
}
