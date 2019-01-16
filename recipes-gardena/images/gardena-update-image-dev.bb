require gardena-update-image.inc

DESCRIPTION = "SWUpdate compound image for gardena-image-dev"

SRC_URI += "\
    file://sw-description \
"

PR = "r2"

# Images to build before building swupdate image
IMAGE_DEPENDS += "gardena-image-dev"

# Images and files that will be included in the .swu image
SWUPDATE_IMAGES += "gardena-image-dev"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
SWUPDATE_IMAGES_FSTYPES[gardena-image-dev] = ".squashfs-xz"
