inherit image_types
inherit kernel-artifact-names

IMAGE_CMD_migrationubi () {
cat << EOF > ubinize-migrationubi-${IMAGE_NAME}.cfg
[rootfs0]
mode=ubi
image=${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.squashfs-xz
vol_id=0
vol_size=0x2815000
vol_type=static
vol_name=rootfs0

[kernel0]
mode=ubi
image=${DEPLOY_DIR_IMAGE}/fitImage
vol_id=2
vol_size=0x41e000
vol_type=static
vol_name=kernel0

[uboot_env0]
mode=ubi
image=uEnv.bin
vol_id=4
vol_size=0x10000
vol_type=static
vol_name=uboot_env0

[uboot_env1]
mode=ubi
image=uEnv.bin
vol_id=5
vol_size=0x10000
vol_type=static
vol_name=uboot_env1

[migrate]
mode=ubi
vol_id=7
vol_type=static
vol_name=migrate
flash_later=1
EOF

	# generate uboot env binary
	mkenvimage -r -s 0x10000 -o uEnv.bin ${DEPLOY_DIR_IMAGE}/uEnv.txt

	# generate ubi image
	migration-ubinize \
	    -o ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.migration.ubi \
	    -m 2048 -p 128KiB -s 2048 \
	    -z ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.migration.ubi.meta \
	    ubinize-migrationubi-${IMAGE_NAME}.cfg

	# Cleanup cfg file
	mv ubinize-migrationubi-${IMAGE_NAME}.cfg ${IMGDEPLOYDIR}/

	# symlinks
	ln -sf ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.migration.ubi \
	    ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.migration.ubi
	ln -sf ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.migration.ubi.meta \
	    ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.migration.ubi.meta
}
IMAGE_TYPEDEP_migrationubi = "squashfs-xz"

do_image_migrationubi[depends] = "\
	migration-mtd-utils-native:do_populate_sysroot \
	u-boot-tools-native:do_populate_sysroot \
	virtual/kernel:do_deploy \
	virtual/bootloader:do_deploy \
"
do_image_migrationubi[recrdeps] = "do_build"
