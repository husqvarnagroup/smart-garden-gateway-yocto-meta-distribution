# Base for all proprietary Gardena images

IMAGE_INSTALL += " \
    accessory-server \
    manufacturing-tools \
    shadoway \
    sysupgrade \
"

inherit gardena-image-opensource
