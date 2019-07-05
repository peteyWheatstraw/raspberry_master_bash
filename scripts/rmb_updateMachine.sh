#! /bin/bash/

function rmb_updateMachine(){
	function update_machine(){
		echo "FETCHING MACHINE UPDATES"
		sudo apt-get update
		rmb_confirm upgrade_machine "ARE YOU SURE YOU WANT TO UPGRADE" "NOT UPGRADING"
	}	
	function upgrade_machine(){
			echo ""
			sudo apt-get upgrade
	}

	
	rmb_confirm update_machine "ARE YOU SURE YOU WANT TO UPDATE??" "THATS RIGHT BACK DOWN BITCH"
}

rmb_updateMachine