require gardena-update-image.inc
IMAGE_FLAVOR = "lona"

SRC_URI += "\
    file://sw-description \
"

PR = "${INC_PR}.0"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
# Variables cannot (!?) be used inside the square brackets, makes it impossible
# to put this line in gardena-update-image.inc.
SWUPDATE_IMAGES_FSTYPES[gardena-image-lona] = ".squashfs-xz"
