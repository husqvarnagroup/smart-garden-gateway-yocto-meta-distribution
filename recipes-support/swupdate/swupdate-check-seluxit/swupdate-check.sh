#!/bin/ash

set -eu -o pipefail

readonly MIGRATION_SERVER=gateway-migration-bnw.iot.sg.dss.husqvarnagroup.net

log_info() {
    logger -p user.info -t swupdate-check "$@"
}

log_warning() {
    logger -p user.warning -t swupdate-check "$@"
}

log_error() {
    logger -p user.err -t swupdate-check "$@"
}

# Make sure the version files exist
# Note: Doing this here might be superflous when executed trough systemd (which
#       is the expected case).
/usr/bin/update-hw-revision
/usr/bin/update-sw-versions

# Get update_url stored in U-Boot to allow using customized update servers
update_url=$(fw_printenv -n update_url 2>/dev/null || echo @DISTRO_UPDATE_URL@?gwVersion=@DISTRO_VERSION_ID@)

# Gateway ID servers (among other) as login credentials for the web interface.
# Guard it by hashing it.
if ! gw_id_hash="$(fw_printenv -n gatewayid | tr -d '\n' | openssl sha1 | awk '{print $2}')"; then
    log_error "Failed to generate a hash of the gateway ID" || true
fi

if shall_update="$(curl -sf "https://${MIGRATION_SERVER}/shall-update/${gw_id_hash}")"; then
    if [ "${shall_update}" = "ok" ]; then
        if ! fw_printenv update_url >/dev/null 2>&1; then
            if healthcheck; then
                log_warning "Migrating to BNW..." || true
                update_url=$(echo "$update_url" | sed 's/prod/bnw/')
                # Report a magic gateway version number to indicate that the migration has started
                echo "6.16.999" > /usr/lib/shadoway/version || true
            else
                log_error "Migration to BNW prevented by failing health check" || true
            fi
        else
            log_warning "\"update_url\" is set in U-Boot, not migrating to BNW" || true
        fi
    else
        log_warning "BNW migration is diabled for this gateway" || true
    fi
else
    log_info "Individual BNW migration information missing" || true
fi

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
