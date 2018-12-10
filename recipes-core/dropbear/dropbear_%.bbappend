PR_append = ".0"

do_install_append() {
    install -d ${D}${sysconfdir}/default
    echo 'DROPBEAR_EXTRA_ARGS="-s"' > ${D}${sysconfdir}/default/dropbear
}
