SUMMARY = "Packages installable via OPKG"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r5"

RDEPENDS_packagegroup-opkg-feed = "\
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-analyze systemd-bootchart', '', d)} \
    atop \
    bash \
    bind-utils \
    chrony \
    chronyc \
    cuitest \
    curl \
    emc-tools \
    ethtool \
    file \
    gdb \
    gdbserver \
    git \
    htop \
    i2c-tools \
    iftop \
    iotop \
    iperf3 \
    iputils \
    lbipsock \
    lsof \
    mc \
    minicom \
    mtd-utils \
    net-tools \
    netcat \
    network-management \
    ntpdate \
    picocom \
    prelink \
    pstree \
    pv \
    python3-paho-mqtt \
    python3-pip \
    rsync \
    rsyslog \
    screen \
    sed \
    shadoway-develop \
    socat \
    srecord \
    strace \
    stresstest-download \
    swdtool \
    tar \
    tcpdump \
    traceroute \
    tshark \
    vim \
    wget \
    wlan-stresstest \
    xz \
    zsh \
    "

RDEPENDS_packagegroup-opkg-feed_append_mt7688 = "\
    valgrind \
"
