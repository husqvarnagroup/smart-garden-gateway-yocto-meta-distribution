DESCRIPTION = "SWUpdate compound image for gardena-image-prod"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://sw-description \
"

# images to build before building swupdate image
IMAGE_DEPENDS = "gardena-image-prod u-boot virtual/kernel"

# images and files that will be included in the .swu image
SWUPDATE_IMAGES = "gardena-image-prod uImage.lzma"

SWUPDATE_IMAGES_FSTYPES[gardena-image-prod] = ".squashfs-xz"
SWUPDATE_IMAGES_FSTYPES[uImage.lzma] = ".bin"

inherit swupdate
