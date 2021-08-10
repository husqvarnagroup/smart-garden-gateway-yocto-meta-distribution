require gardena-update-image.inc
IMAGE_FLAVOR = "prod"

SRC_URI += "\
    file://sw-description \
"

PR = "${INC_PR}.2"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
# Variables cannot (!?) be used inside the square brackets, makes it impossible
# to put this line in gardena-update-image.inc.
SWUPDATE_IMAGES_FSTYPES[gardena-image-prod] = ".squashfs-xz"

# Ensure that the prebuilt U-Boot binary can always be referred to by a stable
# name from uEnv.txt and its do_u_boot_upgrade (LCGW)/do_dev_u_boot_upgrade
# (HCGW 2.0).
#
# For multiple reasons, this is quite an ugly hack:
# - It assumes that we are using prebuilt U-Boot binaries. This should be true
# for every single release, but might be not during development. In such cases,
# this code will stupidly create this link anyway, probably causing some
# confusion down the road.
# - This code gets executed when building *update* images. The real user of
# this file/filename is however U-Boot itself, when it tries to update itself
# during the bootstrapping phase of the manufacturing process.
do_deploy_append() {
    ln -s ${UBOOT_FILENAME_IN_DEPLOYDIR} ${DEPLOYDIR}/prebuilt-u-boot-with-spl.bin-${MACHINE}
}
