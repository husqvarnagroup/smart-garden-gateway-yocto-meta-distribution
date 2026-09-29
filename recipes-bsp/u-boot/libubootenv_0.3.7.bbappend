FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-${PV}:${THISDIR}/files/${MACHINE_ARCH}:"

PR:append = ".0"

SRC_URI += " \
    file://fw_env.config \
    file://0001-fw_printenv-Exit-with-error-code-on-unset-variables.patch \
    file://0002-fw_setenv-Support-extra-long-lines.patch \
"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${UNPACKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config

    # Make tools available under the original paths
    install -d ${D}${base_sbindir}
    ln -s ${bindir}/fw_printenv ${D}${base_sbindir}/fw_printenv
    ln -s ${bindir}/fw_setenv ${D}${base_sbindir}/fw_setenv
}
