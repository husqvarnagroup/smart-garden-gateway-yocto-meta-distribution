inherit swupdate-legacy

require gardena-update-image.inc

SRC_URI += "\
    file://sw-description \
"

PR = "${INC_PR}.2"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
# Variables cannot (!?) be used inside the square brackets, makes it impossible
# to put this line in gardena-update-image.inc.
SWUPDATE_IMAGES_FSTYPES[gardena-image-bnw-zephyr] = ".squashfs-xz"

# This is a workaround to allow multiple SWUpdate images to have their "own"
# (binary blob) copy of U-Boot.
UBOOT_FILENAME_IN_DEPLOYDIR = "${@d.getVar('UBOOT_FILENAME').replace('.bin', '-' + d.getVar('IMAGE_ID') + '.bin')}"

# Since we want the bootloaders binaries to be built (just) once and only
# updated when absolutely needed, keep them stable by using prebuilt binaries.
# The binaries were taken from the official Gateway 9.1.0 build:
# https://github.com/husqvarnagroup/smart-garden-gateway-public/tree/81285c30b2e68216450be8f9b197f77d92c430ef
# The build scripts for the binaries can be found here:
# https://github.com/husqvarnagroup/smart-garden-gateway-yocto-openembedded-core/tree/964ef69ebbd3e9058be8d4306da8946a20f795b6/meta/recipes-bsp/u-boot
UBOOT_VERSION = "2024.01-gardena-1"
UBOOT_FILENAME = "prebuilt-u-boot-with-spl-${MACHINE}_${UBOOT_VERSION}.bin"
SRC_URI:append = "file://${UBOOT_FILENAME}"
do_deploy() {
    install -D -m 644 ${WORKDIR}/${UBOOT_FILENAME} ${DEPLOYDIR}/${UBOOT_FILENAME_IN_DEPLOYDIR}
}
addtask deploy before do_swuimage after do_unpack
