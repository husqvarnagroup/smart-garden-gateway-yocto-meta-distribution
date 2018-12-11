# Base for all proprietary Gardena images

IMAGE_INSTALL += " \
    manufacturing-tools \
    shadoway \
    sysupgrade \
"

inherit gardena-image-opensource
