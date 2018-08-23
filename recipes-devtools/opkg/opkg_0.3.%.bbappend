FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Do-url-encoding-of-file-names-using-the-curl-backend.patch"

# We need curl for our url-encoding hack
PACKAGECONFIG = "curl"
