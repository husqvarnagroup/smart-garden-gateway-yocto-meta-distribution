SUMMARY = "The Gardena image for usage on productive gateways"

IMAGE_INSTALL_append = " initscripts-readonly-rootfs-overlay"

inherit gardena-image
