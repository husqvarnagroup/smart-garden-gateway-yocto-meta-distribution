PR:append = ".1"

RDEPENDS:${PN} += "python3-profile"

# This recipe needs to manage compiled Python files manually.
# Using `INSTALL_WHEEL_COMPILE_BYTECODE` does not work. It uses different
# functionality for packaging than other Python packages in our images.

do_install:prepend() {
    # Compile Python files with optimization level 2
    ${STAGING_BINDIR_NATIVE}/python3-native/python3 -m compileall -o 2 ${B}
}

do_package:append() {
    # Remove all .pyc files that don't have the optimization level 2
    from pathlib import Path
    wd = Path(d.getVar('WORKDIR'))
    for pyc_file in wd.rglob('*.pyc'):
        if not pyc_file.name.endswith('.opt-2.pyc'):
            pyc_file.unlink()
}

INSANE_SKIP:${PN} = "buildpaths"

