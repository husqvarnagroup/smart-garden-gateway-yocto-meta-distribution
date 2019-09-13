FILESEXTRAPATHS_prepend := "${THISDIR}/files/${MACHINE_ARCH}:${THISDIR}/files:"

PR_append = ".4"

SRC_URI += "file://uEnv.txt \
            file://0001-ubi-provide-a-way-to-skip-CRC-checks.patch \
            file://0002-ubi-Print-skip_check-in-ubi_dump_vol_info.patch \
            file://0003-ubi-Add-skipcheck-command-to-set-clear-this-bit-in-t.patch \
            "
