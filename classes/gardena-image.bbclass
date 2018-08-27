# Base for all Gardena images

IMAGE_INSTALL += " \
    dhcpcd \
    i2c-tools \
    initscripts-readonly-rootfs-overlay \
    iw \
    manufacturing-tools \
    memtester \
    mtd-utils \
    mtd-utils-ubifs \
    os-release \
    packagegroup-core-boot \
    ppp \
    squashfs-tools \
    swdtool \
    swupdate \
    u-boot \
    u-boot-fw-utils \
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
