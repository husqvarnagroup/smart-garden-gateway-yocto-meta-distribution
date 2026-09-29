PR:append = ".1"

INSANE_SKIP:${PN}-misc += "staticdev"

# We are compiling all Python files in ROOTFS_POSTPROCESS_COMMAND.
INCLUDE_PYCS = "0"

# gdbm is unused on the gateway - no service references dbm/shelve
PACKAGECONFIG:remove = "gdbm"

# python3-core hard-RDEPENDS on python3-compression (_zstd, gzip, tarfile,
# zipfile). Nothing on the gateway needs it, and constructing an argparse
# parser pulls it in via shutil unconditionally - see yocto/notes.txt
# 2026-08-12 entry.
RDEPENDS:python3-core:remove = "python3-compression"
