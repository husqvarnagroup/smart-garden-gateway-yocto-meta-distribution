#!/bin/sh

POWER_LED=/sys/class/leds/smartgw:power

stage="${1}"
new_version="${2}"

set_power_led_yellow_flash() {
    # note: we're not using 'led-indicator flash' here as it will lead
    # to a visible delay between red and green
    echo oneshot > $POWER_LED:blue/trigger
    echo 0 > $POWER_LED:blue/brightness
    # keep these two together for synchronicity between R and G components
    echo timer > $POWER_LED:red/trigger && echo timer > $POWER_LED:green/trigger
    for x in red/delay_on red/delay_off green/delay_on green/delay_off; do
        echo 500 > $POWER_LED:$x
    done
}

set_power_led_green() {
    for color in red green blue; do
        echo oneshot > $POWER_LED:$color/trigger
    done
    echo 0 > $POWER_LED:red/brightness
    echo 0 > $POWER_LED:blue/brightness
    echo 1 > $POWER_LED:green/brightness
}


do_preinst()
{
    installed_version="$(fw_printenv -n linux_system_version 2>/dev/null || echo unknown)"
    if [ "${installed_version}" = "${new_version}" ]; then
        echo "Version ${new_version} is already installed" >&2
        exit 1
    fi
    set_power_led_yellow_flash
    exit 0
}

do_postinst()
{
    echo "do_postinst"
    set_power_led_green
    exit 0
}

case "${stage}" in
preinst)
    do_preinst
    ;;
postinst)
    do_postinst
    ;;
*)
    echo "Unknown stage" >&2
    exit 1
    ;;
esac
