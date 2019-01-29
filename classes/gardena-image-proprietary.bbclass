# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    gateway-config-interface \
    gateway-firmware \
    manufacturing-tools \
    python3-lemonbeat \
    shadoway \
    sysupgrade \
"

inherit gardena-image-opensource
