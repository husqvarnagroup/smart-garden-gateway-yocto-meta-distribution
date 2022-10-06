FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-${PV}:${THISDIR}/files/${MACHINE_ARCH}:"

PR:append = ".0"

SRC_URI += " \
  file://fw_env.config \
  file://0001-sg-noup-fw_printenv-Exit-with-error-code-on-unset-va.patch \
  file://0002-sg-noup-fw_setenv-Support-extra-long-lines.patch \
  file://0003-Revert-fw_setenv-fix-bug-when-SPI-flash-write-size-s.patch \
"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config

    # Make tools available under the original paths
    install -d ${D}${base_sbindir}
    ln -s ${bindir}/fw_printenv ${D}${base_sbindir}/fw_printenv
    ln -s ${bindir}/fw_setenv ${D}${base_sbindir}/fw_setenv
}
