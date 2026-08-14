FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

SRC_URI += "\
    file://keep.d/${BPN} \
"
FILES:${PN} += "\
    ${base_libdir}/upgrade/keep.d \
"

do_configure:append() {
    # The maintenance access servers only offer the ssh-rsa (SHA-1) host key
    # algorithm, which dropbear disables by default since 2024.84.
    echo "#define DROPBEAR_RSA_SHA1 1" >> ${B}/localoptions.h
}

do_install:append() {
    install -d ${D}${sysconfdir}/default
    echo 'DROPBEAR_EXTRA_ARGS="-s"' > ${D}${sysconfdir}/default/dropbear

    # Keep SSH host key from being erased on update
    install -d ${D}${base_libdir}/upgrade/keep.d
    install -m 0644 ${UNPACKDIR}/keep.d/${PN} ${D}${base_libdir}/upgrade/keep.d
}
