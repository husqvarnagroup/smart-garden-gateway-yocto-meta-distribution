# Add meta-distribution kmeta
FILESEXTRAPATHS_prepend := "${THISDIR}:"
SRC_URI_append = " file://distribution-kmeta;type=kmeta;name=distribution-kmeta;destsuffix=distribution-kmeta"

PR_append = ".1"

KERNEL_FEATURES_append = " \
    distro/disable_kernel_samples.cfg \
    distro/enable_compaction.cfg \
    distro/enable_console.cfg \
    distro/enable_debugfs.cfg \
    distro/enable_devmem.cfg \
    distro/enable_executable_format_elf.cfg \
    distro/enable_executable_format_script.cfg \
    distro/enable_file_locking.cfg \
    distro/enable_keyboard_button.cfg \
    distro/enable_leds.cfg \
    distro/enable_mtd_tests.cfg \
    distro/enable_multiuser.cfg \
    distro/enable_net_sched.cfg \
    distro/enable_netfilter.cfg \
    distro/enable_notify.cfg \
    distro/enable_panic_on_oops.cfg \
    distro/enable_ppp.cfg \
    distro/enable_proc_page_monitor.cfg \
    distro/enable_rfkill.cfg \
    distro/enable_shmem.cfg \
    distro/enable_squashfs.cfg \
    distro/enable_sysrq.cfg \
    distro/enable_systemd_cpuquota.cfg \
    distro/enable_systemd_cpushare.cfg \
    distro/enable_systemd_requirements.cfg \
    distro/enable_systemd_resource_control.cfg \
    distro/enable_systemd_strongly_recommended.cfg \
    distro/enable_systemd_undocumented.cfg \
    distro/enable_tun.cfg \
    distro/enable_ubi.cfg \
    distro/enable_watchdog.cfg \
    distro/enable_wifi_crda.cfg \
    distro/enable_wifi_crypto.cfg \
    distro/set_cfq_scheduler.cfg \
    distro/set_default_loglevel.cfg \
    features/bpf/bpf.scc \
"

KERNEL_FEATURES_append_mt7688 = " \
    distro/disable_wifi_regdb_sigcheck.cfg \
"

# Misc stuff (maybe not even strictly required)
KERNEL_FEATURES_append = "\
    distro/enable_misc_stuff.cfg \
"

# the netfilter feature enables a generic set of configs for iptables;
# however this is more than we need and configures them as modules,
# rather than in-kernel
KERNEL_EXTRA_FEATURES_remove = "features/netfilter/netfilter.scc"
