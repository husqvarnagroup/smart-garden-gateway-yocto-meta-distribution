FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:class-target = "file://0001-Use-optimization-level-2-as-default-for-Python.patch"


PR:append = ".1"

INSANE_SKIP:${PN}-misc += "staticdev"
