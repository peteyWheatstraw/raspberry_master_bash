

rmb_menu_loadScript_INIT=0

function rmb_menu_loadScript(){
	
	if [[ "$rmb_menu_loadScript_INIT" -eq 0 ]]; then
		rmb_findScripts
#		echo "INITIALIZING"
		declare -a foundScripts=("${rmb_findScripts_RETURN[@]}")
		declare -a ls_key=()
		declare -a ls_func=()
		declare -a ls_label=()
		local scriptFound=""
		local scriptCounter=0
		for scriptFound in "${foundScripts[@]}"; do
			ls_key+=("$scriptCounter")
			ls_func+=("rmb_loadScript $scriptFound")
			ls_label+=("LOAD $scriptFound")
			((scriptCounter++))
		done
		ls_key+=("c")
		ls_func+=("clear")
		ls_label+=("clear")

		ls_key+=("q")
		ls_func+=("exitLoop=1")
		ls_label+=("exit")

		rmb_menu_loadScript_INIT=1
	fi	
	
		
	
	function menu_script_text(){
		local foundScript=""
		local textCounter=0
		echo "*******************************"	
		echo "******* LOAD SCRIPT **********"	
		echo "*******************************"	
#		echo ""
#		echo "    ---FOUND SCRIPTS----"
		for foundScript in "${foundScripts[@]}"; do
			echo "-${ls_key[$textCounter]}---${ls_label[$textCounter]}---"
			(( textCounter++ ))
		done
		echo "-------------------------------"		
		while [[ "$textCounter" -lt "${#ls_key[@]}" ]]; do
			echo "-${ls_key[$textCounter]}---${ls_label[$textCounter]}---"
			((textCounter++))		
		done
		echo "----------------------------"
	}

	local exitLoop=0
	local userEntry=""
	while [[ "$exitLoop" -eq 0 ]]; do
		menu_script_text
		read userEntry
		echo "------------------------------------------------------"
		rmb_kfl_findKey "$userEntry"  ls_key
		if [[ "$rmb_kfl_findKey_RETURN" -ne -1 ]]; then
			eval "${ls_func[$rmb_kfl_findKey_RETURN]}"
		else
			echo "UNKNOWN COMMAND"
		fi
	done
	
}

rmb_findScripts_RETURN=()
function rmb_findScripts(){
	rmb_findScripts_RETURN=()
	 while IFS= read -r -d $'\0'; do	
		rmb_findScripts_RETURN+=("$REPLY")
	 done < <(find "$rmb_SETTING_scriptFolder/"*.sh -prune -type f -print0)
}

rmb_menu_loadScript