SUMMARY = "The Gardena image with additional tools for developers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

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

inherit gardena-image-proprietary
