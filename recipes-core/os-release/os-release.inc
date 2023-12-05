require recipes-core/os-release/os-release.bb

VERSION = "${DISTRO_VERSION}"
VERSION_ID = "${DISTRO_VERSION_ID}"
CODENAME = "${DISTRO_CODENAME}"
PRETTY_NAME = "${DISTRO_NAME} ${VERSION}${@' (%s)' % DISTRO_CODENAME if 'DISTRO_CODENAME' in d else ''}"
IMAGE_ID = "${@'${PN}'[len('os-release-'):]}"

OS_RELEASE_FIELDS += "BUILD_ID CODENAME IMAGE_ID"

# Packages like gateway-config-interface depend on the quotes
OS_RELEASE_UNQUOTED_FIELDS = ""

RPROVIDES:${PN} += "virtual/os-release"
RCONFLICTS:${PN} += "os-release"
