
rmb_bashLog_logFolder="./scripts/bashLogs/"



rmb_bashLog_logFile=""

function rmb_bashLog(){
	local logName=""
	rmb_bashLog_logFile=""
	
	
	rmb_bashLog_findLogs
	declare -a foundLogs=("${rmb_bashLog_findLogs_RETURN[0]}")

	declare -a bl_key=()
	declare -a bl_func=()
	declare -a bl_label=()
	
		
	function bl_init(){
		bl_makeArrays			
		bl_menu
	}
	
	function bl_loadLog(){
		local logToLoad="$1"
		if [[ -f "$logToLoad" ]]; then
		   echo "load that shit yo---$logToLoad"	
			bl_logMenu "$logToLoad"
		fi
	}

	function rmb_bashLog_text(){
		echo "*******************************"
		echo "*********** BASH LOG **********"
		echo "*******************************"
		#
		if ! [[ -d "$rmb_bashLog_logFolder" ]]; then
			echo "ERROR----CANT FIND FOLDER---$rmb_bashLog_logFolder"
			echo "ERROR---------RETURNING"
			return		
			# echo "---------SETTING ----rmb_bashLog_logFolder----to----./"
			# rmb_bashLog_logFolder="./"
		fi

		echo "---FOUND LOGS IN--$rmb_bashLog_logFolder--------------------"
		local foundLog=""
		local text_count=0
		for foundLog in "${foundLogs[@]}"; do
			echo "--$text_count----LOAD--$foundLog--"
			((text_count++))
		done
		echo "-----------------------------"
		while [[ "$text_count" -lt "${#bl_label[@]}" ]]; do
			echo "--${bl_key[$text_count]}----${bl_label[$text_count]}"			
			((text_count++))
		done
		echo "-------------------------------------------------------"
	}	

	
	function bl_makeArrays(){
		local foundLog=""
		local logCount=0
		for foundLog in "${foundLogs[@]}"; do
			bl_key+=("$logCount")
			bl_func+=("bl_loadLog $foundLog")
			bl_label+=("test 1")
		done

		bl_key+=("c")
		bl_func+=("clear")
		bl_label+=("clear")

	
		bl_key+=("q")
		bl_func+=("exitLog=1")
		bl_label+=("quit")
	}
	
	function bl_menu(){
		local userInput=""
		local exitLog=0
	
		while [[ "$exitLog" -ne 1 ]]; do
			rmb_bashLog_text
			echo "-----CHOICE NOW PLEASE----"
			read userInput		
			rmb_bashLog_loadKeyFunc "$userInput" bl_key bl_func
			echo "----------------------------------------------------"
		done
	}
	
	function bl_logMenu(){
		declare -a bl_lm_key=()
		declare -a bl_lm_func=()
		declare -a bl_lm_label=()	
			
		bl_lm_key+=("v")
		bl_lm_func+=("bl_viewLog")
		bl_lm_label+=("VIEW LOG")	

		bl_lm_key+=("c")
		bl_lm_func+=("clear")
		bl_lm_label+=("CLEAR")
		
		bl_lm_key+=("q")
		bl_lm_func+=("bl_lm_loopEXIT=1")
		bl_lm_label+=("QUIT")	
	

		
		function bl_viewLog(){
			echo "VIEW THAT SHIT"		
		}
		
		function bl_lm_text(){
		
			echo "*******************************"
			echo "******* LOG MENU **************"
			echo "*******************************"
			
			local bl_lm_count=0
			local whatever=""
			for whatever in "${bl_lm_key[@]}";do
				echo "${bl_lm_key[$bl_lm_count]}-----${bl_lm_label[$bl_lm_count]}"
				((bl_lm_count++))
			done
		}
		
		
		function bl_lm_loop(){
			local bl_lm_loopEXIT=0
			local bl_lm_input=""
			while [[ "$bl_lm_loopEXIT" -eq 0 ]]; do
				bl_lm_text
				echo "-----MAKE SELECTION----"
				read bl_lm_input
			 	rmb_bashLog_loadKeyFunc "$bl_lm_input" bl_lm_key bl_lm_func		
			done
		}
		bl_lm_loop
	}
	bl_init
}

function rmb_bashLog_loadKeyFunc(){
	local keyToFind="$1"
	declare -n keyArray="$2"
	declare -n funcArray="$3"
	local includedDefault=0
	if [[ "$#" -eq 4 ]]; then
		includedDefault=1
	fi

  	local counter=0
  	local foundIndex=-1
  	# echo "keyToFind is $keyToFind"
 
  	while [[ "$counter" -lt "${#keyArray[@]}" ]];do

	#	echo "keyArray[counter] is ${keyArray[counter]}"
   	if [[ "${keyArray[$counter]}" == "$keyToFind" ]]; then
   		if [[ "$foundIndex" -eq -1 ]]; then
   			foundIndex="$counter"	
   	#		echo "FOUND AND SETTING"
   		else
   			echo "ERROR - rmb_bashLog_loadKeyFunc ---- two matching keys found"
   			return
   		fi
   	fi
   	((counter++))
  done
 # echo "foundIndex is $foundIndex"
  if [[ "$foundIndex" -ne -1 ]]; then
  	  eval "${funcArray[$foundIndex]}"
  else
  		echo "NOT FOUND"
  fi
}

rmb_bashLog_findLogs_RETURN=()
function rmb_bashLog_findLogs(){
	rmb_bashLog_findSLogs_RETURN=()
	 while IFS= read -r -d $'\0'; do	
		rmb_bashLog_findLogs_RETURN+=("$REPLY")
	 done < <(find "./scripts/bashLogs/"*.txt -prune -type f -print0)
	 
	 # echo "first found log ${rmb_bashLog_findLogs_RETURN[0]}"
}

rmb_bashLog