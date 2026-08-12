PR:append = ".0"

INSANE_SKIP:${PN}-misc += "staticdev"

# gdbm is unused on the gateway - no service references dbm/shelve
PACKAGECONFIG:remove = "gdbm"
