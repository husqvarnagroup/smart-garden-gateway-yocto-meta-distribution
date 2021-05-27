LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "Image with everything we are allowed to make publicly available"

# Accessory Server dependencies
IMAGE_INSTALL += " \
    ca-certificates \
    cjson \
    curl \
    dnsmasq \
    gnutls \
    hostapd \
    led-indicator \
    libevdev \
    mbedtls \
    mdns \
    openssl \
    systemd \
    u-boot-fw-utils \
    util-linux \
    wpa-supplicant-cli \
"

# Gateway configuration backend dependencies
IMAGE_INSTALL += " \
    openssl \
    openssl-bin \
    openssl-conf \
"

# Shadoway dependencies
IMAGE_INSTALL += " \
    jsoncpp \
    libcryptopp \
    libev \
    libnl \
    log4cpp \
    mbedtls \
    openvpn \
    util-linux \
    zeromq \
"

# Manufacturing tools dependencies
IMAGE_INSTALL += " \
    python3-core \
    python3-crcmod \
    python3-datetime \
    python3-json \
    python3-pyserial \
    python3-threading \
    python3-unittest \
"

# FCT tool dependencies
IMAGE_INSTALL += " \
    iw \
    openocd \
    python3-core \
    python3-datetime \
    python3-evdev \
    systemd \
"

# python3-lemonbeat tool dependencies
IMAGE_INSTALL += " \
    python3-pycrypto \
"

# Allow the image to start
IMAGE_INSTALL += " \
    manufacturing-tools-shim \
"

inherit gardena-image-opensource
