# Base for all GARDENA images; Open Source software only

IMAGE_INSTALL += " \
    devpkginstaller \
    healthcheck \
    iproute2-tc \
    manufacturing-tools-shim \
    memtester \
    ipcforward \
    rsyslog \
    snapshot \
    systemd-networkd \
    tcpdump-sherlock-ppp0 \
    websocketd \
"

inherit gardena-image-base
