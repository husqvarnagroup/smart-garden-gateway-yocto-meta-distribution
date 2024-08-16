LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "Image with everything we are allowed to make publicly available"

# Dependencies of proprietary services
IMAGE_INSTALL += " \
    accessory-server-foss-dependencies \
    cloudadapter-foss-dependencies \
    gateway-config-backend-foss-dependencies \
    lemonbeatd-foss-dependencies \
    lwm2mserver-foss-dependencies \
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

# Misc
IMAGE_INSTALL += " \
    os-release-foss-bnw \
    swupdate-legacy \
"

inherit gardena-image-foss
