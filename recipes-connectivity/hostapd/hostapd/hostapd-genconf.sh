#!/bin/sh
# this tool merges multiple hostapd configs into one because hostapd doesn't
# support that itself.

set -euo pipefail

FINAL_CONF="$1"
shift

append_config() {
    cat "$1" >> "$FINAL_CONF"
}

if [ -f "$FINAL_CONF" ];then
    rm "$FINAL_CONF"
fi
touch "$FINAL_CONF"

for arg in "$@"; do
    if [ -d "$arg" ];then
        for file in $(find "$arg" -name '*.conf' -type f -maxdepth 1 | sort); do
            append_config "$file"
        done
    elif [ -f "$arg" ];then
        append_config "$arg"
    fi
done
