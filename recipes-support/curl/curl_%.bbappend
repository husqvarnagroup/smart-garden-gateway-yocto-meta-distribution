PR:append = ".0"

# IDN support only matters for hostnames outside ASCII. Everything that links
# libcurl here - accessory-server, opkg, rsyslog, swupdate - talks to fixed
# hostnames. Dropping it takes libidn2 and libunistring5 off the image, 0.5 MB
# of the 39.5 MB rootfs.
PACKAGECONFIG:remove = "libidn"
