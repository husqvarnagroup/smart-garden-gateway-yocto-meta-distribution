do_install_append(){
	sed -i '/After=multi-user.target/d' ${D}${systemd_system_unitdir}/wd_keepalive.service
}
