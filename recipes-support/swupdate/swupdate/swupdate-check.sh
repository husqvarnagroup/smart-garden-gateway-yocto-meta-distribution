#!/bin/sh

# Make sure the version files exist
# Note: Doing this here might be superflous when executed trough systemd (which
#       is the expected case).
/usr/bin/update-hw-revision
/usr/bin/update-sw-versions

# Get update_url stored in U-Boot to allow using customized update servers
update_url=$(fw_printenv -n update_url 2>/dev/null || echo @DISTRO_UPDATE_URL@?gwVersion=@DISTRO_VERSION@)

# Get active bootslot
#
# U-Boot variable bootslot:
# Simply parsing the U-Boot variable bootslot is dangerous because it might
# have already been toggled because of a successful installation of an update.
# Running swupdate again without a restart in between would destroy our active
# partition which we are running from. While swupdate-progress should restart
# the gateway immediately after a successful update, and systemd in turn would
# restart swupdate-progress if it ever crashes, it is better to be safe than
# sorry here.
#
# Unfortunately we can parse neither /proc/mounts nor /etc/mtab, because they
# claim that on /media/rfs/ro the device /dev/root is mounted.
if mount | grep -q "^/dev/ubiblock0_0 .* /media/rfs/ro "; then
    bootslot=0
elif mount | grep -q "^/dev/ubiblock0_1 .* /media/rfs/ro "; then
    bootslot=1
else
    echo "Fatal: Can not determine active bootslot. Canceling update attempt." >&2
    exit 1
fi

swupdate -f /etc/swupdate.cfg -e stable,bootslot"${bootslot}" --download "-u ${update_url}"
