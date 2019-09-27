# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    firewall \
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

inherit gardena-image-opensource
