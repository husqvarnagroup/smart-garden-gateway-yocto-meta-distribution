require gardena-update-image.inc

DESCRIPTION = "SWUpdate compound image for gardena-image-prod"

SRC_URI += "\
    file://sw-description \
"

PR = "${INC_PR}.0"

# Images to build before building swupdate image
IMAGE_DEPENDS += "gardena-image-prod"

# Images and files that will be included in the .swu image
SWUPDATE_IMAGES += "gardena-image-prod"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
SWUPDATE_IMAGES_FSTYPES[gardena-image-prod] = ".squashfs-xz"
