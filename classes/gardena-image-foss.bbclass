# Base for all GARDENA images; Open Source software only

IMAGE_INSTALL += " \
    devpkginstaller \
    gateway-config-backend \
    healthcheck \
    iproute2-tc \
    lemonbeatd \
    manufacturing-tools-shim \
    memtester \
    ipcforward \
    rsyslog \
    snapshot \
    tcpdump-sherlock-ppp0 \
    websocketd \
"

inherit gardena-image-base
