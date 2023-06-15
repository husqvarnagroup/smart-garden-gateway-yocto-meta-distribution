# Base for all proprietary GARDENA images

IMAGE_INSTALL += " \
    gateway-firmware \
    rm-test-firmware \
"

IMAGE_INSTALL:append:mt7688 += " \
    manufacturing-tools \
"

IMAGE_INSTALL:append:at91sam9x5 += " \
    manufacturing-tools-migration \
"
inherit gardena-image-foss
