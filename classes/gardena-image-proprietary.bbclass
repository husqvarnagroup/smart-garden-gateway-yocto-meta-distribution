# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    accessory-server \
    firewall \
    gateway-config-backend \
    gateway-firmware \
    lemonbeat-firmware-upload \
    lsdl-serializer-log \
    manufacturing-tools \
    otau \
    python3-lemonbeat \
    shadoway \
    snapshot \
    sysupgrade \
"

inherit gardena-image-opensource
