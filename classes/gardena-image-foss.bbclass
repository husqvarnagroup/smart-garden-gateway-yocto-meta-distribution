# Base for all GARDENA images; Open Source software only

TIME_MANAGEMENT += " \
    ntp \
    tzdata \
    tzdata-africa \
    tzdata-americas \
    tzdata-antarctica \
    tzdata-arctic \
    tzdata-asia \
    tzdata-atlantic \
    tzdata-australia \
    tzdata-europe \
    tzdata-misc \
    tzdata-pacific \
    tzdata-posix \
    tzdata-right \
"

IMAGE_INSTALL += " \
    ${TIME_MANAGEMENT} \
    devpkginstaller \
    healthcheck \
    memtester \
    nngforward \
    rsyslog \
    snapshot \
    tcpdump-sherlock-ppp0 \
"

inherit gardena-image-base
