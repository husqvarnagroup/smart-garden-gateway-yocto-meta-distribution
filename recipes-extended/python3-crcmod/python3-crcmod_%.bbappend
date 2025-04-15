PR:append = ".1"

RDEPENDS:${PN}:remove = "${PYTHON_PN}-unittest"

do_install:prepend:class-target() {
    # Compile Python files with optimization level 2 (skip python2 code)
    ${STAGING_BINDIR_NATIVE}/python3-native/python3 -m compileall -o 2 -x python2 ${B}
}

do_package:append:class-target() {
    from pathlib import Path
    wd = Path(d.getVar('WORKDIR'))

    # Remove all .pyc files that don't have the optimization level 2
    for pyc_file in wd.rglob('*.pyc'):
        if not pyc_file.name.endswith('.opt-2.pyc'):
            pyc_file.unlink()
}
