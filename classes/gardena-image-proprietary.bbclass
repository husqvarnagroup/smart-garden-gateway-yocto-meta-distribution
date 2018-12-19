# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    gateway-firmware \
    manufacturing-tools \
    shadoway \
    sysupgrade \
"

inherit gardena-image-opensource
