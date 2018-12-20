SUMMARY = "Packages installable via OPKG"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"

RDEPENDS_packagegroup-opkg-feed = "\
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-analyze systemd-bootchart', '', d)} \
    atop \
    bash \
    cuitest \
    curl \
    emc-tools \
    gdb \
    gdbserver \
    htop \
    i2c-tools \
    iftop \
    iotop \
    iperf3 \
    lsof \
    mc \
    minicom \
    mtd-utils \
    net-tools \
    netcat \
    network-management \
    ntp \
    ntpdate \
    picocom \
    pstree \
    pv \
    rsync \
    screen \
    sed \
    socat \
    srecord \
    strace \
    swdtool \
    tar \
    tcpdump \
    traceroute \
    vim \
    wget \
    xz \
    zsh \
    "
