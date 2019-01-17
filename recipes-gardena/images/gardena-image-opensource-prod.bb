LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SUMMARY = "Image with everything we are allowed to make publicly available"

do_removepyc() {
    # remove all pyc files from rootfs
    find ${IMAGE_ROOTFS}/ -type f -name "*.pyc" -delete
}

addtask removepyc after do_rootfs before do_image

inherit gardena-image-opensource
