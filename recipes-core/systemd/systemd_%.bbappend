do_install_append() {
	sed -i 's/#RuntimeWatchdogSec=0/RuntimeWatchdogSec=60/g' ${D}${sysconfdir}/systemd/system.conf
	sed -i 's/#ShutdownWatchdogSec=10min/ShutdownWatchdogSec=1min/g' ${D}${sysconfdir}/systemd/system.conf
	sed -i 's/#LogColor=yes/LogColor=no/g' ${D}${sysconfdir}/systemd/system.conf
}
