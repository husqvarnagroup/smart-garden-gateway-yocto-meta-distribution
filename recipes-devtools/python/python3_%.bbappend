PR:append = ".1"

INSANE_SKIP:${PN}-misc += "staticdev"

# We are compiling all Python files in ROOTFS_POSTPROCESS_COMMAND.
INCLUDE_PYCS = "0"

# gdbm is unused on the gateway - no service references dbm/shelve
PACKAGECONFIG:remove = "gdbm"
