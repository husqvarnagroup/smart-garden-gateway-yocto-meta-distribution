FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".5"

SRC_URI += " \
    file://0001-add-libgpiod-jtag-driver.patch \
    file://0001-bitbang-Fix-FTBFS-with-GCC-10.patch \
"

SRC_URI:append:mt7688 = " \
    file://gardena_nrf52.cfg \
    file://gardena_radio.cfg \
"

SRC_URI:append:at91sam9x5 = " \
    file://0002-atmel-performance-hack.patch \
    file://gardena_nrf52.cfg \
    file://gardena_radio.cfg \
"

# We are using upstream and most patches in the base .bb are already upstreamed.
SRC_URI:remove = "file://0001-Add-fallthrough-comments.patch \
                  file://0002-Workaround-new-warnings-generated-by-GCC-7.patch\
                  file://0003-armv7a-Add-missing-break-to-fix-fallthrough-warning.patch \
                  file://0005-command-Move-the-fall-through-comment-to-right-scope.patch"

SRCREV_openocd = "d0be1630dc080b0c881830fa28bf2ccfe7850bb8"

# Available drivers for programmers
# WARNING: The aim of the next few lines is mainly to disable features. Some of
#          those packages might actually depend on libusb1 and/or libftdi.
PACKAGECONFIG[aice] = "--enable-aice,--disable-aice"
PACKAGECONFIG[amtjtagaccel] = "--enable-amtjtagaccel,--disable-amtjtagaccel"
PACKAGECONFIG[armjtagew] = "--enable-armjtagew,--disable-armjtagew"
PACKAGECONFIG[at91rm9200] = "--enable-at91rm9200,--disable-at91rm9200"
PACKAGECONFIG[bcm2835gpio] = "--enable-bcm2835gpio,--disable-bcm2835gpio"
PACKAGECONFIG[buspirate] = "--enable-buspirate,--disable-buspirate"
PACKAGECONFIG[cmsis-dap] = "--enable-cmsis-dap,--disable-cmsis-dap"
PACKAGECONFIG[dummy] = "--enable-dummy,--disable-dummy"
PACKAGECONFIG[ep93xx] = "--enable-ep93xx,--disable-ep93xx"
PACKAGECONFIG[ft232r] = "--enable-ft232r,--disable-ft232r"
PACKAGECONFIG[ftdi] = "--enable-ftdi,--disable-ftdi,libftdi"
PACKAGECONFIG[gw16012] = "--enable-gw16012,--disable-gw16012"
PACKAGECONFIG[imx_gpio] = "--enable-imx_gpio,--disable-imx_gpio"
PACKAGECONFIG[internal-libjaylink] = "--enable-internal-libjaylink,--disable-internal-libjaylink"
PACKAGECONFIG[jlink] = "--enable-jlink,--disable-jlink"
PACKAGECONFIG[jtag_vpi] = "--enable-jtag_vpi,--disable-jtag_vpi"
PACKAGECONFIG[kitprog] = "--enable-kitprog,--disable-kitprog"
PACKAGECONFIG[minidriver-dummy] = "--enable-minidriver-dummy,--disable-minidriver-dummy"
PACKAGECONFIG[oocd_trace] = "--enable-oocd_trace,--disable-oocd_trace"
PACKAGECONFIG[opendous] = "--enable-opendous,--disable-opendous"
PACKAGECONFIG[openjtag] = "--enable-openjtag,--disable-openjtag"
PACKAGECONFIG[osbdm] = "--enable-osbdm,--disable-osbdm"
PACKAGECONFIG[parport] = "--enable-parport,--disable-parport"
PACKAGECONFIG[presto] = "--enable-presto,--disable-presto"
PACKAGECONFIG[rlink] = "--enable-rlink,--disable-rlink"
PACKAGECONFIG[stlink] = "--enable-stlink,--disable-stlink"
PACKAGECONFIG[target64] = "--enable-target64,--disable-target64"
PACKAGECONFIG[ti-icdi] = "--enable-ti-icdi,--disable-ti-icdi"
PACKAGECONFIG[ulink] = "--enable-ulink,--disable-ulink"
PACKAGECONFIG[usb-blaster-2] = "--enable-usb-blaster-2,--disable-usb-blaster-2"
PACKAGECONFIG[usb-blaster] = "--enable-usb-blaster,--disable-usb-blaster"
PACKAGECONFIG[usbprog] = "--enable-usbprog,--disable-usbprog"
PACKAGECONFIG[vsllink] = "--enable-vsllink,--disable-vsllink"
PACKAGECONFIG[xds110] = "--enable-xds110,--disable-xds110"
PACKAGECONFIG[zy1000-master] = "--enable-zy1000-master,--disable-zy1000-master"
PACKAGECONFIG[zy1000] = "--enable-zy1000,--disable-zy1000"

# Non-driver features
PACKAGECONFIG[assert] = "--enable-assert,--disable-assert"
PACKAGECONFIG[werror] = "--enable-werror,--disable-werror"
PACKAGECONFIG[internal-jimtcl] = "--enable-internal-jimtcl,--disable-internal-jimtcl"

PACKAGECONFIG ?= "sysfsgpio internal-jimtcl"

EXTRA_OECONF:remove = "--enable-ftdi"
RDEPENDS:${PN}:remove  = "libusb1"
DEPENDS:remove = "libusb-compat libftdi"

EXTRA_OECONF:append = " --enable-gpiod "
DEPENDS:append = " libgpiod "
RDEPENDS:${PN}:append  = " libgpiod "

do_install:append () {
    install -m 0644 ${WORKDIR}/gardena_radio.cfg ${D}${datadir}/openocd/scripts/board/
    install -m 0644 ${WORKDIR}/gardena_nrf52.cfg ${D}${datadir}/openocd/scripts/board/
}
