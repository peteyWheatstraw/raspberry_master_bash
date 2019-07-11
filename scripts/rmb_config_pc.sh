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

function rmb_config_fixRaspMouse(){

  # backup the file
  #cp /boot/cmdline.txt ./BACKUP_boot_cmdline.txt

  echo "******************************"
  echo "*** OPENING /boot/cmdline.txt "
  echo "******************************"
  echo ""
  echo "AT END OF FIRST LINE"
  echo "ADD THE FOLLOWING"
  echo ""
  echo "usbhid.mousepoll=0"
  echo ""
  echo "under stand?"
  echo "y/n"
  local response=""
  read response
  if [[ "$response" == "y" ]]; then
    sudo nano /boot/cmdline.txt
  else
    echo "NOT OPENING"
  fi
}