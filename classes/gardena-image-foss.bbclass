# Base for all GARDENA images; Open Source software only

IMAGE_INSTALL += " \
    devpkginstaller \
    healthcheck \
    iproute2-tc \
    manufacturing-tools-shim \
    memtester \
    nngforward \
    chrony \
    chronyc \
    rsyslog \
    snapshot \
    tcpdump-sherlock-ppp0 \
"

inherit gardena-image-base
