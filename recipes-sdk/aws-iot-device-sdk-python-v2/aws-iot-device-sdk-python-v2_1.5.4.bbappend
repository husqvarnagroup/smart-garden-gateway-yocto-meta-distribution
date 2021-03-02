FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

PR_append = ".0"

SRC_URI += " \
  file://0001-Fix-dependency-on-awscrt.patch \
"
