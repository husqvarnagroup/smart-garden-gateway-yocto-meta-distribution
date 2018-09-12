SUMMARY = "The Gardena image for usage on productive gateways"

IMAGE_INSTALL += " \
    ssh-authorized-keys-prod \
"

inherit gardena-image
