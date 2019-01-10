SUMMARY = "The GARDENA image with additional tools for developers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# tools-profile would be nice to have, but pulls in (too) many X11 dependencies
IMAGE_FEATURES += "tools-debug"
IMAGE_INSTALL += " \
    cuitest \
    homekit-devscripts \
    kernel-module-mtd-nandbiterrs \
    kernel-module-mtd-nandecctest \
    kernel-module-mtd-oobtest \
    kernel-module-mtd-pagetest \
    kernel-module-mtd-readtest \
    kernel-module-mtd-speedtest \
    kernel-module-mtd-stresstest \
    kernel-module-mtd-subpagetest\
    kernel-module-mtd-torturetest \
    linux-serial-test \
    openssh-sftp-server \
    picocom \
    ssh-authorized-keys-dev \
    wifi-certification-util \
    wifi-testsuite \
    wpa-supplicant-cli \
"

# Useful for nfsroot
IMAGE_FSTYPES += "tar.bz2"

inherit gardena-image-proprietary
