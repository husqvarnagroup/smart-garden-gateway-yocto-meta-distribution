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

ROOTFS_POSTPROCESS_COMMAND += '${@bb.utils.contains("IMAGE_FEATURES", "python-sourceless", "rootfs_python_sourceless ", "", d)}'

# Files in the Python tree that no interpreter ever reads.
PYTHON_SOURCELESS_JUNK ?= "*.pyi py.typed .gitignore"

python rootfs_python_sourceless () {
    import fnmatch
    import os

    tree = oe.path.join(d.getVar("IMAGE_ROOTFS"), d.getVar("libdir"),
                        "python" + d.getVar("PYTHON_BASEVERSION"))
    if not os.path.isdir(tree):
        bb.warn("%s does not exist, nothing to make sourceless" % tree)
        return

    # The build host's python is not necessarily the target's, so its
    # sys.implementation.cache_tag cannot be used.
    tag = ".cpython-%s" % d.getVar("PYTHON_BASEVERSION").replace(".", "")
    junk = d.getVar("PYTHON_SOURCELESS_JUNK").split()

    moved = 0
    freed = 0
    kept = set()

    for parent, dirs, files in os.walk(tree):
        for name in files:
            if any(fnmatch.fnmatch(name, pattern) for pattern in junk):
                path = os.path.join(parent, name)
                freed += os.path.getsize(path)
                os.remove(path)

        if "__pycache__" not in dirs:
            continue
        cache = os.path.join(parent, "__pycache__")

        sources = []
        for name in sorted(os.listdir(cache)):
            stem = name[:-len(".pyc")] if name.endswith(".pyc") else ""
            optimization = ""
            if ".opt-" in stem:
                stem, _, optimization = stem.rpartition(".")
            if not stem.endswith(tag):
                bb.warn("Unexpected %s, left in place" % os.path.join(cache, name))
                kept.add(cache)
                continue
            module = stem[:-len(tag)]
            source = os.path.join(parent, module + ".py")
            if not os.path.exists(source):
                # Unreachable without its source, whether the module is
                # already sourceless or some recipe removed the source after
                # compiling it. Nothing can import this, so drop it.
                freed += os.path.getsize(os.path.join(cache, name))
                os.remove(os.path.join(cache, name))
                continue
            if optimization:
                # The legacy layout has a single path per module, so
                # optimized bytecode becomes unreachable once the source is
                # gone. Only _sysconfigdata has any, from oe-core's
                # py_package_preprocess.
                freed += os.path.getsize(os.path.join(cache, name))
                os.remove(os.path.join(cache, name))
                continue
            os.replace(os.path.join(cache, name),
                       os.path.join(parent, module + ".pyc"))
            sources.append(source)
            moved += 1

        # Sources go last so that a module's optimized bytecode is still
        # recognized as such whatever order the directory lists its files in.
        for source in sources:
            freed += os.path.getsize(source)
            os.remove(source)

        if os.listdir(cache):
            bb.warn("%s not empty: %s" % (cache, " ".join(sorted(os.listdir(cache)))))
        else:
            os.rmdir(cache)

    left = []
    for parent, dirs, files in os.walk(tree):
        # A directory in kept holds a file this class did not recognize and
        # therefore refused to touch. It was warned about above and is not a
        # sign of an incomplete conversion.
        if os.path.basename(parent) == "__pycache__" and parent not in kept:
            bb.fatal("%s survived, sourceless layout is incomplete" % parent)
        left += [os.path.join(parent, f) for f in files if f.endswith(".py")]

    if left:
        # Importing these still works, they just cost their own size. A recipe
        # that installs modules by hand instead of through PEP 517 ships no
        # bytecode for them.
        bb.warn("No bytecode for %d source file(s), kept as source: %s"
                % (len(left), " ".join(sorted(left))))

    bb.note("Made %d module(s) sourceless, freeing %d bytes" % (moved, freed))
}
