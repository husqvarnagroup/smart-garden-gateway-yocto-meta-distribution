LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit swupdate

INC_PR = "r8"

# Images to build before building swupdate image
IMAGE_DEPENDS = "virtual/kernel u-boot"

# Define U-Boot filename and version
UBOOT_FILENAME = "u-boot-${MACHINE}.bin"
UBOOT_FILENAME_at91sam9x5 = "u-boot-with-spl.bin-${MACHINE}"
UBOOT_VERSION = "${@d.getVar("PREFERRED_VERSION_u-boot", False).replace("-prebuilt", "")}"

# Images and files that will be included in the .swu image
SWUPDATE_IMAGES = "fitImage uEnv"
SWUPDATE_IMAGES_append_mt7688 = " u-boot"
SWUPDATE_IMAGES_append_at91sam9x5 = " u-boot-with-spl.bin"

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
HARDWARE_COMPATIBILITY_mt7688 = "[ "0.5", "1.0", "1.1.0", "1.2.0" ]"
HARDWARE_COMPATIBILITY_at91sam9x5 = "[ "1.1b" ]"

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
