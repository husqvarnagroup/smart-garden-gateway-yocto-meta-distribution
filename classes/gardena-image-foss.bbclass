# Base for all GARDENA images; Open Source software only

IMAGE_INSTALL += " \
    devpkginstaller \
    healthcheck \
    ipcforward \
    iproute2-tc \
    manufacturing-tools-shim \
    memtester \
    rsyslog \
    snapshot \
    tcpdump-sherlock-ppp0 \
    websocketd \
"

inherit gardena-image-base
