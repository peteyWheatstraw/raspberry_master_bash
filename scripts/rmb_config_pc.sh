function rmb_config_rasp_byUtility(){
	raspi-config
}

function rmb_config_rasp_byEditFile(){
	sudo nano /boot/config.txt
}

function rmb_config_bash(){
	sudo nano ~/.bashrc
}

function rmb_bash_viewHistory(){
	sudo bluefish ~/.bash_history
}

function rmb_diskfree(){
	df -h
}
