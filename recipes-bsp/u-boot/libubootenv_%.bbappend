FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:${THISDIR}/files/${MACHINE_ARCH}:"

PR_append = ".1"

SRC_URI += " \
  file://fw_env.config \
  file://0001-fw_printenv-Exit-with-error-code-on-unset-variables.patch \
  file://0002-shared-library-Link-against-zlib.patch \
"

# Prevent U-Boot from being built
# RRECOMMENDS_libubootenv-bin_remove = "u-boot-default-env"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config

    # Make tools available under the original paths
    install -d ${D}${base_sbindir}
    ln -s ${bindir}/fw_printenv ${D}${base_sbindir}/fw_printenv
    ln -s ${bindir}/fw_setenv ${D}${base_sbindir}/fw_setenv
}
