FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# tar_ignore_error.patch touches the same lines as 0001-opkg-utils-do-not-set-mtime-on-data.tar.X.patch
# and therefore needs to be adapted.
SRC_URI_remove = "file://tar_ignore_error.patch"

SRC_URI += " \
    file://0001-opkg-utils-do-not-set-mtime-on-data.tar.X.patch \
    file://tar_ignore_error-adapted.patch \
"

PR_append = ".1"
