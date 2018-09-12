SUMMARY = "The Gardena image with additional tools for developers"

# tools-profile would be nice to have, but pulls in (too) many X11 dependencies
IMAGE_FEATURES += "tools-debug"
IMAGE_INSTALL += " \
    cuitest \
    openssh-sftp-server \
    picocom \
    ssh-authorized-keys-dev \
"

# Useful for nfsroot
IMAGE_FSTYPES += "tar.bz2"

inherit gardena-image
