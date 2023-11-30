# Base for all GARDENA images; Open Source software only

IMAGE_INSTALL += " \
    dhcpcd \
    dnsmasq \
    environment \
    firewall \
    hostapd \
    i2c-tools \
    initscripts-readonly-rootfs-overlay \
    iptables \
    iptables-modules \
    iw \
    jq \
    kernel-module-nft-compat \
    kernel-module-nft-counter \
    kernel-module-nft-ct \
    kernel-module-xt-dscp \
    libubootenv-bin \
    lsof \
    mtd-utils \
    mtd-utils-ubifs \
    nftables \
    openocd \
    packagegroup-core-boot \
    ppp \
    reset-rm \
    rfkill \
    squashfs-tools \
    swupdate \
    systemd-conf \
    systemd-extra-utils \
    sysupgrade \
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
    unique-hostname \
    wireless-regdb-static \
    wpa-supplicant \
    wpa-supplicant-cli \
    zram-init \
    virtual/os-release \
"

IMAGE_INSTALL:append:mt7688 += " \
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

compress_lic_files() {
    lic_dir_rootfs="${IMAGE_ROOTFS}/usr/share/common-licenses"
    XZ_OPT="-9e" tar -C "${lic_dir_rootfs}" -cJf "${WORKDIR}/licenses.tar.xz" .
    rm -rf "${lic_dir_rootfs}"/*
    install -m 0644 "${WORKDIR}/licenses.tar.xz" "${lic_dir_rootfs}/"
}
ROOTFS_POSTPROCESS_COMMAND:append = "compress_lic_files; "

