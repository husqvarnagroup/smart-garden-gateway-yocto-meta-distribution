# Base for all Gardena images

IMAGE_INSTALL += "packagegroup-core-boot mtd-utils ppp \
                  python3-core \
                  python3-datetime \
                  python3-json \
                  python3-threading \
                  python3-unittest"

IMAGE_FEATURES += "ssh-server-dropbear package-management"

# We do not need any additional locales
IMAGE_LINGUAS = " "

# The rootfs is (will be) a read only squashfs in an UBI container
IMAGE_FSTYPES += " squashfs-xz"

LICENSE = "MIT"

# Default rootfs size: 40 MB
IMAGE_ROOTFS_SIZE ?= "40960"

inherit core-image
