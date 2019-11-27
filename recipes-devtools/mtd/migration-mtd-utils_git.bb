SUMMARY = "Tools for managing memory technology devices"
HOMEPAGE = "http://www.linux-mtd.infradead.org/"
SECTION = "base"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3 \
                    file://include/common.h;beginline=1;endline=17;md5=ba05b07912a44ea2bf81ce409380049c"

inherit autotools pkgconfig update-alternatives

DEPENDS = "zlib e2fsprogs util-linux"
RDEPENDS_mtd-utils-tests += "bash"

PV = "2.1.1"

SRCREV = "18d7bd618cda71cc664cbdb3366ac30a5c3479cc"
SRC_URI = "git://stash.dss.husqvarnagroup.com:7999/sg/mtd-utils.git;protocol=ssh \
           file://add-exclusion-to-mkfs-jffs2-git-2.patch \
"

S = "${WORKDIR}/git/"

# xattr support creates an additional compile-time dependency on acl because
# the sys/acl.h header is needed. libacl is not needed and thus enabling xattr
# regardless whether acl is enabled or disabled in the distro should be okay.
PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'xattr', d)} lzo jffs ubifs"
PACKAGECONFIG[lzo] = "--with-lzo,--without-lzo,lzo"
PACKAGECONFIG[xattr] = "--with-xattr,--without-xattr,acl"
PACKAGECONFIG[crypto] = "--with-crypto,--without-crypto,openssl"
PACKAGECONFIG[jffs] = "--with-jffs,--without-jffs"
PACKAGECONFIG[ubifs] = "--with-ubifs,--without-ubifs"
PACKAGECONFIG[zstd] = "--with-zstd,--without-zstd,zstd"

CPPFLAGS_append_riscv64  = " -pthread -D_REENTRANT"

EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS} ${@bb.utils.contains('PACKAGECONFIG', 'xattr', '', '-DWITHOUT_XATTR', d)} -I${S}/include' 'BUILDDIR=${S}'"

do_compile () {
	oe_runmake ubinize
}

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ubinize ${D}${sbindir}/migration-ubinize
}


BBCLASSEXTEND = "native nativesdk"

# git/.compr.c.dep:46: warning: NUL character seen; rest of line ignored
# git/.compr.c.dep:47: *** missing separator.  Stop.
PARALLEL_MAKE = ""
