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
    mbedtls \
    mdns \
    network-management \
    u-boot-fw-utils \
    util-linux \
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
    util-linux \
    zeromq \
"

# Manufacturing tools dependencies
IMAGE_INSTALL += " \
    python3-core \
    python3-datetime \
    python3-json \
    python3-threading \
    python3-unittest \
"

inherit gardena-image-opensource
