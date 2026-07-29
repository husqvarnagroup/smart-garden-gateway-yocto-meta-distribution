# The sdist installs its test suite and documentation as top-level directories
# in site-packages (~240 files in "tests", ~143 in "docs"), which is of no use
# on the target and costs about 7 MiB.
do_install:append() {
    rm -rf ${D}${PYTHON_SITEPACKAGES_DIR}/tests
    rm -rf ${D}${PYTHON_SITEPACKAGES_DIR}/docs
}
