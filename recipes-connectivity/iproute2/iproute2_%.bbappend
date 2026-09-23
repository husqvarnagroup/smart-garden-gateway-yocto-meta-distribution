PR:append = ".0"

DEPENDS:remove = "iptables"

# Without iptables, /usr/lib/tc stays an empty directory. do_package fails on
# it, because it is installed but not shipped.
do_install:append () {
    rmdir --ignore-fail-on-non-empty ${D}${libdir}/tc
}
