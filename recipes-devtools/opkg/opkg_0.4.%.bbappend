FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Do-url-encoding-of-file-names-using-the-curl-backend.patch"

PR_append = ".1"

# We need curl for our url-encoding hack
PACKAGECONFIG = "curl"

# We want to use HTTPS
RDEPENDS_${PN} += "ca-certificates"
