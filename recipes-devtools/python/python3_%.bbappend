PR:append = ".2"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:class-target = "file://0001-Use-optimization-level-2-as-default-for-Python.patch"

# The upstream recipe supports only unoptimized .pyc files. So disable that.
INCLUDE_PYCS = "0"

do_install:prepend:class-target() {
    # Compile Python files with optimization level 2
    ${STAGING_BINDIR_NATIVE}/python3-native/python3 -m compileall -o 2 ${B}
}


do_package:append:class-target() {
    from pathlib import Path
    wd = Path(d.getVar('WORKDIR'))

    # Remove all .pyc files that don't have the optimization level 2
    for pyc_file in wd.rglob('*.pyc'):
        if not pyc_file.name.endswith('.opt-2.pyc'):
            pyc_file.unlink()
}

INSANE_SKIP:${PN}-misc += "staticdev"
INSANE_SKIP:${PN}-misc += "buildpaths"

