SUMMARY = "Packages installable via OPKG"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r11"

RDEPENDS:packagegroup-opkg-feed = "\
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-analyze systemd-bootchart', '', d)} \
    atop \
    bash \
    bind-utils \
    chrony \
    chronyc \
    conntrack-tools \
    cuitest \
    curl \
    emc-tools \
    ethtool \
    file \
    gdb \
    gdbserver \
    git \
    homekit-devscripts \
    htop \
    i2c-tools \
    iftop \
    iotop \
    iperf2 \
    iperf3 \
    iproute2-ip \
    iputils \
    lsof \
    mc \
    minicom \
    mtd-utils \
    net-tools \
    netcat-openbsd \
    nftables \
    openssh \
    picocom \
    pstree \
    pv \
    python3-aiocoap \
    python3-dbus-next \
    python3-lemonbeat \
    python3-opentelemetry-exporter-otlp-proto-http \
    python3-opentelemetry-sdk \
    python3-paho-mqtt \
    python3-pip \
    python3-toml \
    python3-ubootenv \
    rsync \
    rsyslog \
    screen \
    sed \
    socat \
    srecord \
    ssh-authorized-keys-dev \
    strace \
    stresstest-download \
    tar \
    tcpdump \
    traceroute \
    tshark \
    vim \
    wakaama \
    wget \
    wifi-certification-util \
    wlan-stresstest \
    xz \
    zsh \
    "
