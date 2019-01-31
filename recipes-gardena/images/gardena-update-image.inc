LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit swupdate

# Images to build before building swupdate image
IMAGE_DEPENDS = "u-boot virtual/kernel"

# Images and files that will be included in the .swu image
SWUPDATE_IMAGES = "fitImage u-boot uEnv"

# Configure file extensions of the images (potentially) used in SWUPDATE_IMAGES
SWUPDATE_IMAGES_FSTYPES[fitImage] = ".bin"
SWUPDATE_IMAGES_FSTYPES[u-boot] = ".bin"
SWUPDATE_IMAGES_FSTYPES[uEnv] = ".txt"

# In order to sign the image, the variables SWUPDATE_SIGNING, SWUPDATE_CMS_KEY,
# and SWUPDATE_CMS_CERT need to be set. [1]
# Please do so by either adding them to our local.conf file or by exporting them
# to bitbake in bash (adding them to BB_ENV_EXTRAWHITE) before building this
# image. [2]
# [1] https://sbabic.github.io/swupdate/building-with-yocto.html#template-for-recipe-using-the-class
# [2] https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html#var-BB_ENV_EXTRAWHITE
#SWUPDATE_SIGNING = "CMS"
#SWUPDATE_CMS_KEY = "/path/to/key.pem"
#SWUPDATE_CMS_CERT = "/path/to/cert.pem"
