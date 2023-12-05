IMAGE_ID = "${@'${PN}'[len('gardena-update-image-'):]}"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
DESCRIPTION = "SWUpdate compound image for gardena-image-${IMAGE_ID}"

inherit swupdate deploy

INC_PR = "r15"

# Images to build before building swupdate image
IMAGE_DEPENDS = "virtual/kernel u-boot gardena-image-${IMAGE_ID}"

# Define U-Boot filename and version. This is only relevant when the "freshly"
# built U-Boot binary should get used. See comment below this section.
UBOOT_FILENAME = "u-boot-${MACHINE}.bin"
UBOOT_FILENAME:at91sam9x5 = "u-boot-with-spl.bin-${MACHINE}"
UBOOT_VERSION = "${@d.getVar("PREFERRED_VERSION_u-boot", False).replace("-prebuilt", "")}"
UBOOT_VERSION = "XXX"
# This is a workaround to allow multiple SWUpdate images having their "own"
# copy of U-Boot.
UBOOT_FILENAME_IN_DEPLOYDIR = "${@d.getVar('UBOOT_FILENAME').replace('.bin', '-' + d.getVar('IMAGE_ID') + '.bin')}"

# Since we want the bootloaders binaries to be buit (just) once and only
# updated when absolutely needed, keep them stable by using prebuilt binaries.
# The sources for the binaries can be found here:
# - mt7688 (2019.01-rc2-mt7688-2018-12-18-gardena-rc2-yocto): https://github.com/husqvarnagroup/smart-garden-u-boot/commit/e6f4ac2a81f76be4e07f200f1aa6e9c2e389859e
# - at91am (2019.10-gardena-2): https://github.com/husqvarnagroup/smart-garden-gateway-public/tree/release/linux-system-4.3.2
UBOOT_FILENAME:mt7688 = "prebuilt-u-boot-with-spl-${MACHINE}_${UBOOT_VERSION}.bin"
UBOOT_FILENAME:at91sam9x5 = "prebuilt-u-boot-with-spl-${MACHINE}_${UBOOT_VERSION}.bin"
UBOOT_VERSION:mt7688 = "2021.04-gardena-6"
UBOOT_VERSION:at91sam9x5 = "2021.04-gardena-6"
SRC_URI:append = "file://${UBOOT_FILENAME}"
do_deploy() {
    install -D -m 644 ${WORKDIR}/${UBOOT_FILENAME} ${DEPLOYDIR}/${UBOOT_FILENAME_IN_DEPLOYDIR}
}
addtask deploy before do_swuimage after do_unpack

# Images and files that will be included in the .swu image
SWUPDATE_IMAGES = "fitImage uEnv gardena-image-${IMAGE_ID} ${UBOOT_FILENAME_IN_DEPLOYDIR}"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
SWUPDATE_IMAGES_FSTYPES[fitImage] = ".bin"
SWUPDATE_IMAGES_FSTYPES[u-boot] = ".bin"
SWUPDATE_IMAGES_FSTYPES[uEnv] = ".txt"

# We had smart-gateway-mt7688 in swupdate as hardware identification string and
# need to keep this pattern in order to be able to update every existing gateway.
# Since we will never ever be able to get rid of this, we do not try to
# set/migrate to the proper MACHINE string here, and even align the at91sam
# based gateway.
SWUPDATE_HARDWARE_NAME = "smart-gateway-${@d.getVar("MACHINE", False).replace("gardena-sg-", "")}"

# Set the compatible hardware revisions which are different for all architectures
HARDWARE_COMPATIBILITY:mt7688 = "[ "0.5", "1.0", "1.1.0", "1.2.0", "1.2.1" ]"
HARDWARE_COMPATIBILITY:at91sam9x5 = "[ "1.1b" ]"

# In order to sign the image, the variables SWUPDATE_SIGNING, SWUPDATE_CMS_KEY,
# and SWUPDATE_CMS_CERT need to be set. [1]
# Please do so by either adding them to our local.conf file or by exporting them
# to bitbake in bash (adding them to BB_ENV_EXTRAWHITE) before building this
# image. [2]
# [1] https://sbabic.github.io/swupdate/building-with-yocto.html#template-for-recipe-using-the-class
# [2] https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html#var-BB_ENV_EXTRAWHITE
#SWUPDATE_SIGNING = "CMS"
#SWUPDATE_CMS_KEY = "/path/to/key.pem"
#SWUPDATE_CMS_CERT = "/path/to/cert.pem"
