# Base for all proprietary Gardena images

IMAGE_INSTALL += " \
    manufacturing-tools \
    shadoway \
    sysupgrade \
    accessory-server \
    gateway-firmware \
"

inherit gardena-image-opensource
