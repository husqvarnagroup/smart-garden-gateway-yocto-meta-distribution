SUMMARY = "The Gardena image with additional tools for developers"

# tools-profile would be nice to have, but pulls in (too) many X11 dependencies
IMAGE_FEATURES += "tools-debug"
IMAGE_INSTALL += " \
    cuitest \
    linux-serial-test \
    openssh-sftp-server \
    picocom \
    ssh-authorized-keys-dev \
    wifi-testsuite \
    wpa-supplicant-cli \
"

# Useful for nfsroot
IMAGE_FSTYPES += "tar.bz2"

inherit gardena-image
