PACKAGECONFIG:append = " libnftnl"

do_install:append() {
    # the iptables package uses xtables-legacy-multi as default, change that
    for _x in iptables iptables-save iptables-restore ip6tables ip6tables-save ip6tables-restore; do
        ln -sf xtables-nft-multi "${D}${sbindir}/$_x"
    done
}
