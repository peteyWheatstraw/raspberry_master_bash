#! /bin/bash



rmb_SETTING_scriptFolder="./scripts"


rmb_exitSwitch=0

rmb_menu_main_keyFuncLabel=()
rmb_menu_main_keyFuncLabel+=("ls" "rmb_loadScript $rmb_SETTING_scriptFolder/rmb_menu_loadScript.sh" "LOAD SCRIPT")
rmb_menu_main_keyFuncLabel+=("t" "rmb_test" "run rmb_test function")
rmb_menu_main_keyFuncLabel+=("update" "rmb_loadScript $rmb_SETTING_scriptFolder/rmb_updateMachine.sh" "update machine")
rmb_menu_main_keyFuncLabel+=("q" "rmb_menu_main_exit" "quit")


rmb_kfl_key_=()
rmb_kfl_func=()
rmb_kfl_label=()

function rmb_kfl_createArrays(){
  declare -n kfl="$1"
  
  rmb_kfl_key_=()
  rmb_kfl_func=()
  rmb_kfl_labal=()

  local kfl_len="${#kfl[@]}"
  local kfl_amount=$((kfl_len / 3))
  local counter=0
  local index=0

  while [[ "$counter" -lt "$kfl_amount" ]];do     
    rmb_kfl_key+=("${kfl[((index))]}")
    rmb_kfl_func+=("${kfl[(( index + 1 ))]}")
    rmb_kfl_label+=("${kfl[(( index + 2 ))]}")
    ((counter++))
    index=$(( $counter * 3 ))
  done    
  
  if [[ "$#" -gt 1 ]]; then
    declare -n sentKeyArray="$2"
    declare -n sentFuncArray="$3"
    declare -n sentLabelArray="$4"
    
    counter="${sentKeyArray[@]}"
    local dummy=""
    for dummy in "${rmb_kfl_key[@]}"; do
      sentKeyArray["$counter"]="${rmb_kfl_key[$counter]}"
      sentFuncArray["$counter"]="${rmb_kfl_func[$counter]}"
      sentLabelArray["$counter"]="${rmb_kfl_label[$counter]}"

#     echo "key func label ---${sentKeyArray[$counter]}---${sentFuncArray[$counter]}---${sentLabelArray[$counter]}---"
      ((counter++))
    done
  fi
  
  
}


rmb_kfl_findKey_RETURN=-1
function rmb_kfl_findKey(){
      rmb_kfl_findKey_RETURN=-1
      local sentKey="$1"
      declare -n keyArray="$2"

      local counter=0
      while [[ "$counter" -lt "${#keyArray[@]}" ]];do
      if [[ "${keyArray[counter]}" == "$sentKey" ]]; then
        if [[ "$rmb_kfl_findKey_RETURN" -eq -1 ]]; then
          rmb_kfl_findKey_RETURN="$counter" 
        else
          echo "ERROR - rmb_loadkey ---- two matching keys found"
          return
        fi
      fi
      ((counter++))
    done
}

rmb_menu_main_INIT=0
function rmb_menu_main(){
  rmb_menu_main_exitSwitch=0
  local choice=""

  declare -a key=()
  declare -a func=()
  declare -a label=()
  
  rmb_kfl_createArrays rmb_menu_main_keyFuncLabel key func label
  
  function rmb_menu_main_exit(){
    rmb_menu_main_exitSwitch=1  
  }
  
  function menu_text(){
    echo "*******************************"  
    echo "******* MAIN MENU  **********"  
    echo "*******************************"  
    echo ""
    
    local counter=0
    local dummy=""
    for dummy in "${key[@]}"; do
      echo "${key[$counter]} - ${label[$counter]}"
      (( counter++ ))     
    done
    echo "-------------------------------------" 
  } 
  
  while [[ "$rmb_menu_main_exitSwitch" -eq 0 ]];do
    menu_text
    read choice
    echo "-------------------------------------" 
        
    rmb_kfl_findKey "$choice"  key
    if [[ "$rmb_kfl_findKey_RETURN" -ne -1 ]]; then
      ${func[$rmb_kfl_findKey_RETURN]}
    else
      echo "UNKNOWN COMMAND"
    fi
  done
}

rmb_loadScript(){
  local scriptToLoad="$1"

  if [ -f "$scriptToLoad" ]; then
    source "$scriptToLoad"  
  else
    echo "ERROR --rmb_loadScript---SCRIPT NOT FOUND---$scriptToLoad"
  fi
}



function rmb_test(){

  echo "RMB TEST FUNCTION"
  
}

function rmb_init(){
  rmb_menu_main
}

function rmb_confirm(){
  if [[ "$#" -lt 1 ]]; then
    echo "ERROR IN ~~~~~~rmb_confirm-----INCORRECT AMOUNT OF ARGUMENTS"
    return
  else
    local confirmMessage="are you sure?"
    local failMessage="not executing"
    if [[ "$#" -gt 1 ]]; then
    
      if [[ "$#" -ge 2 ]]; then
        confirmMessage="$2"
      fi
      if [[ "$#" -eq 3 ]]; then
        failMessage="$3"
      fi
      if [[ "$#" -gt 3 ]]; then
        echo "ERROR IN -----rmb_confirm----too many arguments"
        return
      fi
    fi
  fi
  local choice="n"
  echo "$confirmMessage"
  echo "y/n"
  echo ""
  read choice
  case $choice in 
    y)
      $1
      ;;
    *)
      echo "$failMessage"
      ;;
  esac
    
}


rmb_init