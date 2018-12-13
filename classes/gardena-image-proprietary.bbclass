# Base for all proprietary Gardena images

IMAGE_INSTALL += " \
    accessory-server \
    manufacturing-tools \
    shadoway \
    sysupgrade \
    accessory-server \
    gateway-firmware \
"

inherit gardena-image-opensource
