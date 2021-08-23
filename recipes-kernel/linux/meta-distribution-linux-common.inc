# Add meta-distribution kmeta
FILESEXTRAPATHS_prepend := "${THISDIR}:"
SRC_URI_append = " file://distribution-kmeta;type=kmeta;name=distribution-kmeta;destsuffix=distribution-kmeta"

PR_append = ".9"

KERNEL_FEATURES_append = " \
    distro.cfg \
    features/bpf/bpf.scc \
"

# the netfilter feature enables a generic set of configs for iptables;
# however this is more than we need and configures them as modules,
# rather than in-kernel
KERNEL_EXTRA_FEATURES_remove = "features/netfilter/netfilter.scc"
