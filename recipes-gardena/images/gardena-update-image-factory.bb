inherit swupdate-legacy

require gardena-update-image.inc

SRC_URI += "\
    file://sw-description \
"

PR = "${INC_PR}.1"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
# Variables cannot (!?) be used inside the square brackets, makes it impossible
# to put this line in gardena-update-image.inc.
SWUPDATE_IMAGES_FSTYPES[gardena-image-factory] = ".squashfs-xz"

# The (current) manufacturing process requires a file named
# `prebuilt-u-boot-with-spl.bin-gardena-sg-mt7688`. By adding a symlink, the CI
# pipeline will upload U-Boot with that name to S3.
do_deploy:append() {
    ln -rs ${DEPLOYDIR}/${UBOOT_FILENAME_IN_DEPLOYDIR} ${DEPLOYDIR}/prebuilt-u-boot-with-spl.bin-${MACHINE}
}
