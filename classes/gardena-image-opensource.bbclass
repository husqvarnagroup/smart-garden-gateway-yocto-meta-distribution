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
    firewall \
    healthcheck \
    hostapd \
    i2c-tools \
    initscripts-readonly-rootfs-overlay \
    iptables \
    iptables-modules \
    iw \
    jq \
    lsof \
    memtester \
    mtd-utils \
    mtd-utils-ubifs \
    openocd \
    openvpn \
    os-release \
    packagegroup-core-boot \
    ppp \
    reset-rm \
    rfkill \
    rsyslog \
    squashfs-tools \
    swupdate \
    systemd-conf \
    systemd-container \
    tcpdump-sherlock-ppp0 \
    tcpdump-sherlock-vpn0 \
    u-boot-fw-utils \
    unique-hostname \
    wireless-regdb-static \
    wpa-supplicant \
"

IMAGE_INSTALL_append_mt7688 += " \
    kernel-module-mt7603e \
    linux-firmware-mt7628 \
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
