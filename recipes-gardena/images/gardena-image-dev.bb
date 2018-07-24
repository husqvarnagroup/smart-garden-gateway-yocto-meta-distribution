SUMMARY = "The Gardena image with additional tools for developers"

# tools-profile would be nice to have, but pulls in (too) many X11 dependencies
IMAGE_FEATURES += "tools-debug debug-tweaks"

# Useful for nfsroot
IMAGE_FSTYPES += "tar.bz2"

inherit gardena-image
