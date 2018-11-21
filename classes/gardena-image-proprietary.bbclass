# Base for all proprietary Gardena images

IMAGE_INSTALL += " \
    manufacturing-tools \
    sysupgrade \
"

inherit gardena-image-opensource
