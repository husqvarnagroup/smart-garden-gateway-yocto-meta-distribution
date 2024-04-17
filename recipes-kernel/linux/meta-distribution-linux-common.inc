# Add meta-distribution kmeta
FILESEXTRAPATHS:prepend := "${THISDIR}:"
SRC_URI:append = " file://distribution-kmeta;type=kmeta;name=distribution-kmeta;destsuffix=distribution-kmeta"

PR:append = ".14"

KERNEL_FEATURES:append = " \
    distro.cfg \
    features/bpf/bpf.scc \
"

# the netfilter feature enables a generic set of configs for iptables;
# however this is more than we need and configures them as modules,
# rather than in-kernel
KERNEL_EXTRA_FEATURES:remove = "features/netfilter/netfilter.scc"
