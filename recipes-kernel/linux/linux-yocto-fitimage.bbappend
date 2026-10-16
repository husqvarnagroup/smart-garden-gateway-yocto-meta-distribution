# The recipe deploys the FIT image under its bare name only. The U-Boot
# development commands in uEnv.txt fetch it by the machine-suffixed name that
# the kernel used to deploy, so keep a link under that name.
do_deploy:append() {
    ln -snf fitImage "${DEPLOYDIR}/fitImage-${KERNEL_FIT_LINK_NAME}${KERNEL_FIT_BIN_EXT}"
}
