DESCRIPTION = "Lemonbeat Python library"
LICENSE = "CLOSED"

inherit python3-dir

SRC_URI += " \
    git://stash.dss.husqvarnagroup.com/scm/sg/lemonbeat-python.git;protocol=https \
"

PR = "r0"

SRCREV = "aea59ad0b95b97aa97403381842ac33b1e4d56a1"

S = "${WORKDIR}/git"

RDEPENDS_${PN} += " \
    lsdl-serializer-lib \
    python3-core \
    python3-threading \
"

do_install() {
    install -d ${D}${PYTHON_SITEPACKAGES_DIR}
    install -m 0755 ${S}/lemonbeat/configuration.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/defines.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/device_description.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/device.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/firmware.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/gateway.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/__init__.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/message.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/partner.py ${D}${PYTHON_SITEPACKAGES_DIR}/
    install -m 0755 ${S}/lemonbeat/types.py ${D}${PYTHON_SITEPACKAGES_DIR}/
}

FILES_${PN} += " \
    ${PYTHON_SITEPACKAGES_DIR}/configuration.py \
    ${PYTHON_SITEPACKAGES_DIR}/defines.py \
    ${PYTHON_SITEPACKAGES_DIR}/device_description.py \
    ${PYTHON_SITEPACKAGES_DIR}/device.py \
    ${PYTHON_SITEPACKAGES_DIR}/firmware.py \
    ${PYTHON_SITEPACKAGES_DIR}/gateway.py \
    ${PYTHON_SITEPACKAGES_DIR}/__init__.py \
    ${PYTHON_SITEPACKAGES_DIR}/message.py \
    ${PYTHON_SITEPACKAGES_DIR}/partner.py \
    ${PYTHON_SITEPACKAGES_DIR}/types.py \
"
