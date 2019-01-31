# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    gateway-config-backend \
    gateway-firmware \
    lb-fw-upload \
    manufacturing-tools \
    python3-lemonbeat \
    shadoway \
    sysupgrade \
"

inherit gardena-image-opensource
