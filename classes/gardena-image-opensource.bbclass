# Base for all GARDENA images; Open Source software only

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
    dnsmasq \
    hostapd \
    i2c-tools \
    initscripts-readonly-rootfs-overlay \
    iw \
    kernel-module-mt7603e \
    linux-firmware-mt7628 \
    memtester \
    mtd-utils \
    mtd-utils-ubifs \
    openocd \
    openvpn \
    os-release \
    packagegroup-core-boot \
    ppp \
    rfkill \
    squashfs-tools \
    swupdate \
    u-boot \
    u-boot-fw-utils \
    wireless-regdb-static \
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
IMAGE_FSTYPES = "tar.bz2 squashfs-xz"

LICENSE = "MIT"

# Default rootfs size: 40 MB
IMAGE_ROOTFS_SIZE ?= "40960"

inherit core-image
