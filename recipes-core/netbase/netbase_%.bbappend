FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PR:append = ".1"

# Appending rather than using patches to simplify updating the base package
do_install:append() {
    cat <<EOF >> ${D}${sysconfdir}/services

# Lemonbeat ports
lemonbeat-value               20000/tcp
lemonbeat-value               20000/udp
lemonbeat-device-description  20001/tcp
lemonbeat-device-description  20001/udp
lemonbeat-public-key          20002/tcp
lemonbeat-public-key          20002/udp
lemonbeat-network-management  20003/tcp
lemonbeat-network-management  20003/udp
lemonbeat-value-description   20004/tcp
lemonbeat-value-description   20004/udp
lemonbeat-service-description 20005/tcp
lemonbeat-service-description 20005/udp
lemonbeat-memory-information  20006/tcp
lemonbeat-memory-information  20006/udp
lemonbeat-partner-information 20007/tcp
lemonbeat-partner-information 20007/udp
lemonbeat-action              20008/tcp
lemonbeat-action              20008/udp
lemonbeat-calculation         20009/tcp
lemonbeat-calculation         20009/udp
lemonbeat-timer               20010/tcp
lemonbeat-timer               20010/udp
lemonbeat-calendar            20011/tcp
lemonbeat-calendar            20011/udp
lemonbeat-state-machine       20012/tcp
lemonbeat-state-machine       20012/udp
lemonbeat-firmware-update     20013/tcp
lemonbeat-firmware-update     20013/udp
lemonbeat-channel-scan        20014/tcp
lemonbeat-channel-scan        20014/udp
lemonbeat-status              20015/tcp
lemonbeat-status              20015/udp
lemonbeat-configuration       20016/tcp
lemonbeat-configuration       20016/udp

# HomeKit Accessory Protocol
# Note: this port was chosen by us and is not a HomeKit default
homekit-accessory-protocol    8001/tcp
EOF
}
