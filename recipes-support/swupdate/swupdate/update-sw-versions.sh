#!/bin/sh
#
# This script extracts the versions of the installed components (U-Boot,
# rootfs, kernel and saves those values in order to allow SWUpdate to determine
# the components (images) it needs to update.

set -u

u_boot_version="$(strings /dev/mtd0 | grep "U-Boot 20" | awk '{print $2}')"
if [ $? -ne 0 ]; then
    echo "Failed to extract the U-Boot version from /dev/mtd0!" >&2
    exit 1
fi

rootfs_version="$(cat /etc/version)"
if [ $? -ne 0 ]; then
    echo "Failed to extract the rootfs version" >&2
    exit 2
fi

kernel_version="$(uname -r)"
if [ $? -ne 0 ]; then
    echo "Failed to extract the kernel version" >&2
    exit 3
fi

echo "u-boot ${u_boot_version}" > /tmp/sw-versions
echo "kernel ${kernel_version}" >> /tmp/sw-versions
echo "rootfs ${rootfs_version}" >> /tmp/sw-versions
