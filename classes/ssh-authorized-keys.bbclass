# Base class for all SSH pubkey packages
# To use this class, simply append all *.pub files you want to end up in the
# authorized_keys file for SSH_USER to the SRC_URI variable.
#
# Caution: Packages inheriting from this recipe AND having non-distinct SSH_USER
#          values will be incompatible with each other.

inherit allarch

SSH_USER ?= "root"

FILES_${PN} += "/home/${SSH_USER}/.ssh/authorized_keys"

do_install() {
        install -d ${D}/home/${SSH_USER}/.ssh/
        cat ${WORKDIR}/*.pub > ${D}/home/${SSH_USER}/.ssh/authorized_keys
        chmod 600 ${D}/home/${SSH_USER}/.ssh/authorized_keys
}
