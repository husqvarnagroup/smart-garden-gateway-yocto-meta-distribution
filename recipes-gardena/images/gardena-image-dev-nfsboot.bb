LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "Developer image bootable via NFS"

inherit gardena-image-foss

# Firewall would block NFS traffic
IMAGE_INSTALL:remove = "firewall"

# SWUpdate makes no sense when booting from NFS
IMAGE_INSTALL:remove = "swupdate swupdate-check"

IMAGE_INSTALL += " \
    accessory-server \
    cloudadapter \
    coap-transport-proxy \
    fwrolloutd \
    gateway-config-backend \
    gateway-firmware \
    lemonbeatd \
    lwm2mserver \
    nngforward \
    os-release-dev-nfsboot \
    ppp-network \
    ssh-authorized-keys-dev \
    sshtunnel \
    sshtunnel-check \
"

# Stuff to make developers happy
IMAGE_INSTALL += " \
    gdb \
    gdbserver \
"

# Tarball is all we need. No compression to speed things up.
IMAGE_FSTYPES = "tar"

# Image size may grow way beyond our gateways storage size (→ 1GB)
IMAGE_ROOTFS_SIZE = "1048576"
