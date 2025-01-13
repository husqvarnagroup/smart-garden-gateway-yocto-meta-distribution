inherit swupdate-legacy

require gardena-update-image.inc

SRC_URI += "\
    file://sw-description \
"

PR = "${INC_PR}.2"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
# Variables cannot (!?) be used inside the square brackets, makes it impossible
# to put this line in gardena-update-image.inc.
SWUPDATE_IMAGES_FSTYPES[gardena-image-factory] = ".squashfs-xz"

# This is a workaround to allow multiple SWUpdate images to have their "own"
# (binary blob) copy of U-Boot.
UBOOT_FILENAME_IN_DEPLOYDIR = "${@d.getVar('UBOOT_FILENAME').replace('.bin', '-' + d.getVar('IMAGE_ID') + '.bin')}"

# Since we want the bootloaders binaries to be buit (just) once and only
# updated when absolutely needed, keep them stable by using prebuilt binaries.
# The sources for the binaries can be found here:
# - mt7688 (2019.01-rc2-mt7688-2018-12-18-gardena-rc2-yocto): https://github.com/husqvarnagroup/smart-garden-u-boot/commit/e6f4ac2a81f76be4e07f200f1aa6e9c2e389859e
# - at91am (2019.10-gardena-2): https://github.com/husqvarnagroup/smart-garden-gateway-public/tree/release/linux-system-4.3.2
UBOOT_VERSION = "2021.04-gardena-6"
UBOOT_FILENAME = "prebuilt-u-boot-with-spl-${MACHINE}_${UBOOT_VERSION}.bin"
SRC_URI:append = "file://${UBOOT_FILENAME}"
do_deploy() {
    install -D -m 644 ${WORKDIR}/${UBOOT_FILENAME} ${DEPLOYDIR}/${UBOOT_FILENAME_IN_DEPLOYDIR}
}
addtask deploy before do_swuimage after do_unpack

# The (current) manufacturing process requires a file named
# `prebuilt-u-boot-with-spl.bin-gardena-sg-mt7688`. By adding a symlink, the CI
# pipeline will upload U-Boot with that name to S3.
do_deploy:append() {
    ln -rs ${DEPLOYDIR}/${UBOOT_FILENAME_IN_DEPLOYDIR} ${DEPLOYDIR}/prebuilt-u-boot-with-spl.bin-${MACHINE}
}
