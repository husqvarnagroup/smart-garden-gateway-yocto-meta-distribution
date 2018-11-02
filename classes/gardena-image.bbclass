# Base for all Gardena images

IMAGE_INSTALL += " \
    dhcpcd \
    i2c-tools \
    initscripts-readonly-rootfs-overlay \
    iw \
    kernel-module-mt7603e \
    linux-firmware-mt7628 \
    manufacturing-tools \
    memtester \
    mtd-utils \
    mtd-utils-ubifs \
    openocd \
    os-release \
    packagegroup-core-boot \
    ppp \
    squashfs-tools \
    swupdate \
    u-boot \
    u-boot-fw-utils \
    wpa-supplicant \
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
