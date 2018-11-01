do_isntall_append(){
	sed -i '/After=multi-user.target/d' ${D}${systemd_system_unitdir}/debian/wd_keepalive.service
}
