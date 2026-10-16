PR:append = ".0"

INSANE_SKIP:${PN}-misc += "staticdev"

# gdbm is unused on the gateway - no service references dbm/shelve
PACKAGECONFIG:remove = "gdbm"

# python3-core hard-RDEPENDS on python3-compression (_zstd, gzip, tarfile,
# zipfile). Nothing on the gateway needs it, and constructing an argparse
# parser pulls it in via shutil unconditionally - see yocto/notes.txt
# 2026-08-12 entry.
RDEPENDS:python3-core:remove = "python3-compression"

# oe-core's python3-manifest.json lists these .py files in python3-core and
# python3-stringold but names no matching entry under "cached", so their .pyc
# fall through to python3-misc, which the image does not install. Python then
# compiles them on every device that has not done so yet and writes the result
# into the read-write overlay. `string` became a package in 3.14, and the
# manifest still points at the flat pre-3.14 path for it.
FILES:python3-core += " \
    ${libdir}/python${PYTHON_MAJMIN}/__pycache__/annotationlib.*.pyc \
    ${libdir}/python${PYTHON_MAJMIN}/__pycache__/_ast_unparse.*.pyc \
    ${libdir}/python${PYTHON_MAJMIN}/__pycache__/_py_warnings.*.pyc \
    ${libdir}/python${PYTHON_MAJMIN}/__pycache__/zipimport.*.pyc \
"
FILES:python3-stringold += " \
    ${libdir}/python${PYTHON_MAJMIN}/string/__pycache__/__init__.*.pyc \
    ${libdir}/python${PYTHON_MAJMIN}/string/__pycache__/templatelib.*.pyc \
"
