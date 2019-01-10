#!/bin/sh

stage="${1}"
new_version="${2}"

do_preinst()
{
    installed_version="$(fw_printenv -n linux_system_version 2>/dev/null || echo unknown)"
    if [ "${installed_version}" = "${new_version}" ]; then
        echo "Version ${new_version} is already installed" >&2
        exit 1
    fi
    exit 0
}

do_postinst()
{
    echo "do_postinst"
    exit 0
}

case "${stage}" in
preinst)
    do_preinst
    ;;
postinst)
    do_postinst
    ;;
*)
    echo "Unknown stage" >&2
    exit 1
    ;;
esac
