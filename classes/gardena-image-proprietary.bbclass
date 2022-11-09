# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    gateway-firmware \
    lemonbeat-firmware-upload \
    python3-lemonbeat \
    rm-test-firmware \
"

IMAGE_INSTALL_append_mt7688 += " \
    manufacturing-tools \
"

IMAGE_INSTALL_append_at91sam9x5 += " \
    manufacturing-tools-migration \
"
inherit gardena-image-opensource
