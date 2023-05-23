PR:append = ".2"

VERSION = "${DISTRO_VERSION}"
VERSION_ID = "${DISTRO_VERSION_ID}"
CODENAME = "${DISTRO_CODENAME}"
PRETTY_NAME = "${DISTRO_NAME} ${VERSION}${@' (%s)' % DISTRO_CODENAME if 'DISTRO_CODENAME' in d else ''}"

OS_RELEASE_FIELDS += "BUILD_ID CODENAME"

# Packages like gateway-config-interface depend on the quotes
OS_RELEASE_UNQUOTED_FIELDS = ""
