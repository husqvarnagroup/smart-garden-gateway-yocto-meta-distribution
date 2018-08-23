# Base for all Gardena images

IMAGE_INSTALL += "packagegroup-core-boot \
                  dhcpcd \
                  initscripts-readonly-rootfs-overlay \
                  memtester \
                  mtd-utils \
                  mtd-utils-ubifs \
                  ppp \
                  python3-core \
                  python3-datetime \
                  python3-json \
                  python3-threading \
                  python3-unittest \
                  squashfs-tools \
"

IMAGE_FEATURES += " \
    empty-root-password \
    package-management \ 
    ssh-server-dropbear \
"

# We do not need any additional locales
IMAGE_LINGUAS = " "

# The rootfs is (will be) a read only squashfs in an UBI container
IMAGE_FSTYPES += " squashfs-xz"

LICENSE = "MIT"

# Default rootfs size: 40 MB
IMAGE_ROOTFS_SIZE ?= "40960"

inherit core-image
