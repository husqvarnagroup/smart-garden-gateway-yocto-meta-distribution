# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    gateway-config-backend \
    gateway-firmware \
    lemonbeat-firmware-upload \
    lsdl-serializer-log \
    otau \
    python3-lemonbeat \
    shadoway \
    snapshot \
    sysupgrade \
"

IMAGE_INSTALL_append_mt7688 += " \
    manufacturing-tools \
"

IMAGE_INSTALL_append_at91sam9x5 += " \
    manufacturing-tools-shim \
"
inherit gardena-image-opensource
