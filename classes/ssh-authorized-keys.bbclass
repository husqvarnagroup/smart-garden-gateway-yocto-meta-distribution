# Base class for all SSH pubkey packages
# To use this class, simply append all *.pub files you want to end up in the
# authorized_keys file for SSH_USER to the SRC_URI variable.
#
# Caution: Packages inheriting from this recipe AND having non-distinct SSH_USER
#          values will be incompatible with each other.

inherit allarch

FILES:${PN} += "${ROOT_HOME}/.ssh/authorized_keys"

do_install() {
        install -d ${D}${ROOT_HOME}/.ssh/
        cat ${WORKDIR}/*.pub > ${D}${ROOT_HOME}/.ssh/authorized_keys
        chmod 600 ${D}${ROOT_HOME}/.ssh/authorized_keys
}
