SECTION = "console/network"
SUMMARY = "dhcpcd - a DHCP client"
DESCRIPTION = "dhcpcd runs on your machine and silently configures your computer to work on the attached networks without trouble and mostly without configuration."

HOMEPAGE = "http://roy.marples.name/projects/dhcpcd/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0531457992a97ecebc6975914a874a9d"

UPSTREAM_CHECK_URI = "https://roy.marples.name/downloads/dhcpcd/"

SRC_URI = "http://roy.marples.name/downloads/${BPN}/${BPN}-${PV}.tar.xz \
           file://0001-remove-INCLUDEDIR-to-prevent-build-issues.patch"
SRC_URI[md5sum] = "5d3edd06595130f2b24609aade342488"
SRC_URI[sha256sum] = "66b50199ed83bf502af3fab9ac001b417f0fac7e69c92d97a9c41499cebabd4f"

inherit pkgconfig autotools-brokensep

PACKAGECONFIG ?= "udev ${@bb.utils.filter('DISTRO_FEATURES', 'ipv6', d)}"

PACKAGECONFIG[udev] = "--with-udev,--without-udev,udev,udev"
PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6"

EXTRA_OECONF = "--enable-ipv4"

FILES_${PN}-dbg += "${libdir}/dhcpcd/dev/.debug"
