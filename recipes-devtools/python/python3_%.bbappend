PR:append = ".1"

INSANE_SKIP:${PN}-misc += "staticdev"

# we are compiling all Python files in ROOTFS_POSTPROCESS_COMMAND
INCLUDE_PYCS = "0"
