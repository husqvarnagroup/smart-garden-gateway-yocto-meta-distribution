SUMMARY = "The GARDENA image used for migration"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

IMAGE_INSTALL += " \
    openssh-sftp-server \
    ssh-authorized-keys-dev \
    wpa-supplicant-cli \
"

TIME_MANAGEMENT += " \
    ntp \
    tzdata \
    tzdata-africa \
    tzdata-americas \
    tzdata-antarctica \
    tzdata-arctic \
    tzdata-asia \
    tzdata-atlantic \
    tzdata-australia \
    tzdata-europe \
    tzdata-misc \
    tzdata-pacific \
    tzdata-posix \
    tzdata-right \
"

IMAGE_INSTALL += " \
    ${TIME_MANAGEMENT} \
    dhcpcd \
    iw \
    mtd-utils \
    mtd-utils-ubifs \
    os-release \
    packagegroup-core-boot \
    rfkill \
    u-boot-fw-utils \
    unique-hostname \
    wireless-regdb-static \
    wpa-supplicant \
"

IMAGE_FEATURES += " \
    empty-root-password \
    ssh-server-dropbear \
"

# We do not need any additional locales
IMAGE_LINGUAS = " "

# The rootfs is a ramdisk
IMAGE_FSTYPES = "cpio.gz"

# Default rootfs size: 8 MB
IMAGE_ROOTFS_SIZE ?= "8192"

inherit core-image
