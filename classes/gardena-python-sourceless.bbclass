# Ship Python bytecode without the sources it was compiled from.
#
# PEP 3147 bytecode in __pycache__/<mod>.cpython-<tag>.pyc is only reachable
# through <mod>.py: FileFinder matches the source suffix and derives the cache
# path from it, so deleting the source makes the module unimportable. The
# legacy sourceless layout, <mod>.pyc where the source used to be, is what
# SourcelessFileLoader picks up.
#
# Enabled with the python-sourceless IMAGE_FEATURE.

inherit python3-dir

IMAGE_FEATURES[validitems] += "python-sourceless"

# The bytecode must come from the target Python version, not the host Python
# that runs BitBake. python3-native has the same version as the target.
PYTHON_SOURCELESS_NATIVE = "${STAGING_BINDIR_NATIVE}/${PYTHON_PN}-native/${PYTHON_PN}"
do_rootfs[depends] += "${PYTHON_PN}-native:do_populate_sysroot"

# Magic number (first 4 bytes of a .pyc) of the target Python version.
# Update it when the Python version changes, e.g.:
#   Python 3.12 (Yocto Scarthgap): cb0d0d0a
#   Python 3.14 (Yocto Wrynose):   2b0e0d0a
PYTHON_SOURCELESS_MAGIC = "cb0d0d0a"

# Only the Python library tree is made sourceless. Scripts in other places
# (e.g. /usr/bin/foo.py) are run by path and need their source.
PYTHON_SOURCELESS_DIR = "${libdir}/${PYTHON_DIR}"

ROOTFS_POSTPROCESS_COMMAND += '${@bb.utils.contains("IMAGE_FEATURES", "python-sourceless", "rootfs_python_sourceless ", "", d)}'

ROOTFS_POSTPROCESS_COMMAND += '${@bb.utils.contains("IMAGE_FEATURES", "python-sourceless", "rootfs_python_qa_sourceless ", "", d)}'

def python_sourceless_compile(d, python_files, stripdir, optimization_level):
    import subprocess

    # compileall flags:
    # -b: write each .pyc next to its source, the legacy layout that
    #     SourcelessFileLoader reads.
    # -f: overwrite an existing .pyc, so a stale file is never kept.
    # -q: print only errors. The output is shown only when the build fails.
    # -o: optimization level. Level 2 removes docstrings and asserts.
    # --invalidation-mode unchecked-hash: the import does not check the
    #     source. The source is deleted, so it cannot be checked.
    # -s: remove the rootfs path from the file names stored in the .pyc.
    # -p /: add "/" to the names, so they match the paths on the target.
    # -i -: read the list of files to compile from stdin.
    cmd = [d.getVar("PYTHON_SOURCELESS_NATIVE"), "-m", "compileall",
           "-b", "-f", "-q", "-o", str(optimization_level),
           "--invalidation-mode", "unchecked-hash",
           "-s", str(stripdir), "-p", "/", "-i", "-"]
    result = subprocess.run(cmd, input="\n".join(str(f) for f in python_files),
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            text=True)
    if result.returncode != 0:
        bb.fatal("Failed to compile Python files:\n%s" % result.stdout)

python rootfs_python_sourceless () {
    import shutil
    from pathlib import Path

    # Level 2 (like python -OO) removes docstrings and assert statements to save
    # space. Code that reads docstrings at runtime (e.g. click, ply, docopt)
    # does not work as expected.
    PYC_OPTIMIZATION_LEVEL = 2
    PYTHON_SOURCELESS_JUNK = ["*.pyi", "py.typed", ".gitignore"]

    rootfs = Path(d.getVar("IMAGE_ROOTFS"))
    tree = rootfs / d.getVar("PYTHON_SOURCELESS_DIR").lstrip("/")
    if not tree.is_dir():
        bb.note("%s does not exist, nothing to make sourceless" % str(tree))
        return

    # Compile to .pyc and remove now unused Python source files
    python_files = list(tree.rglob("*.py"))
    if len(python_files) == 0:
        bb.warn("No python files in %s" % str(tree))
    uncompiled_files = [f for f in python_files if not f.with_suffix(".pyc").is_file()]
    if uncompiled_files:
        bb.note("Compiling %d Python files" % len(uncompiled_files))
        python_sourceless_compile(d, uncompiled_files, rootfs, PYC_OPTIMIZATION_LEVEL)
    for python_file in python_files:
        pyc_file = python_file.with_suffix(".pyc")
        if pyc_file.is_file():
            bb.note("Removing: %s" % str(python_file))
            python_file.unlink()

    # remove junk
    for junk_pattern in PYTHON_SOURCELESS_JUNK:
        junk = list(tree.rglob(junk_pattern))
        for junk_file in junk:
            bb.note("Removing: %s" % str(junk_file))
            junk_file.unlink()

    cache_dirs = [path for path in tree.rglob("__pycache__") if path.is_dir()]
    for cache_dir in cache_dirs:
        bb.note("Removing: %s" % str(cache_dir))
        shutil.rmtree(cache_dir)

    bb.note("Made rootfs containing only compiled Python modules")
}

python rootfs_python_qa_sourceless () {
    from pathlib import Path
    import struct

    PYTHON_SOURCELESS_JUNK_PATTERNS_QA = ["*.pyi", "py.typed", ".gitignore", "__pycache__"]

    rootfs = Path(d.getVar("IMAGE_ROOTFS"))
    tree = rootfs / d.getVar("PYTHON_SOURCELESS_DIR").lstrip("/")
    if not tree.is_dir():
        return
    errors = []

    # Check that no Python junk files present in image.
    for junk_pattern in PYTHON_SOURCELESS_JUNK_PATTERNS_QA:
        junk = list(tree.rglob(junk_pattern))
        if len(junk) != 0:
            errors.append("Unexpected Python junk present in rootfs: %s" % '\n'.join([str(j) for j in junk]))

    # Check that no .py files are present in image.
    py_files = list(tree.rglob("*.py"))
    if len(py_files) != 0:
        errors.append("Unexpected Python files present in rootfs: %s" % '\n'.join([str(py_file) for py_file in py_files]))

    expected_magic = bytes.fromhex(d.getVar("PYTHON_SOURCELESS_MAGIC"))
    for pyc_file in tree.rglob("*.pyc"):
        with open(pyc_file, 'rb') as f:
            # Byte 0-3: Magic Number (Python-Version)
            magic = f.read(4)

            if magic != expected_magic:
                errors.append("Expected pyc magic number %s found %s for file %s" % (expected_magic.hex(), magic.hex(), str(pyc_file)))

            # Byte 4-7: Invalidation bitmask (PEP 552)
            bitmask_bytes = f.read(4)

            if len(bitmask_bytes) < 4:
                errors.append("Invalid header for compiled Python file (.pyc): %s" % str(pyc_file))
                continue

            bitmask = struct.unpack('<I', bitmask_bytes)[0]

            # PEP 552 flags: bit 0 = hash-based, bit 1 = check source (unchecked-hash: bit 0 only)
            expected_bitmask = 0b01
            if bitmask != expected_bitmask:
                errors.append("Expected pyc flags %#x found %#x for file %s" % (expected_bitmask, bitmask, str(pyc_file)))

    if errors:
        bb.fatal("Python sourceless QA failed:\n%s" % "\n".join(errors))
}
