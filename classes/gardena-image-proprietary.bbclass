# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    gateway-config-backend \
    gateway-firmware \
    lemonbeat-firmware-upload \
    manufacturing-tools \
    otau \
    python3-lemonbeat \
    shadoway \
    sysupgrade \
"

inherit gardena-image-opensource
