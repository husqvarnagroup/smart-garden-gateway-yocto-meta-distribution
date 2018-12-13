#!/bin/sh

set -u

# Get update_url stored in U-Boot to allow using customized update servers
update_url=$(fw_printenv -n update_url 2>/dev/null || echo @DISTRO_UPDATE_URL@)

# Get active bootslot
# Warning: After a successfull update you should reboot immediatelly as a
#          second run of this script would overwrite the bootpartition the
#          system is currently running on!
# TODO: Make this more robust. See warning for details.
bootslot=$(fw_printenv -n bootslot 2>&-)
if [ $? -eq 0 ]; then
    echo "Updating image"
    swupdate -f /etc/swupdate.cfg -e stable,bootslot"${bootslot}" --download "-u ${update_url}"
else
    echo "Failed to extract bootslot value from U-Boot"
fi
