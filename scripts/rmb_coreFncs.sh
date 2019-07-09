##################################
# COPIED COREFNCS
##################################


# MODIFIED TO REMOVE ECHO ERROR CALLS
function file_loadState(){
  if [[ "$#" -ne 1 ]]; then
    echo "echoError insufficient arguments"
    return
  fi
  local fileLoc="$1"
  if ! [[ -f "$fileLoc" ]]; then
    "echoError NOT A VALID FILE TO LOAD ---$fileLoc----"
    return
  fi
  while IFS='' read -r line || [[ -n "$line" ]]; do
    
    # if line is not whitespace? - does not skip tabs
    if [[ (${#line} -gt 0) ]]; then
      #check to see if its an available file
      eval "$line"
    fi
  done < "$fileLoc"
}
  function file_loadState_example(){
    file_saveState_example
    file_loadState "./_saveStates/_EXAMPLE_TEST.txt"
    echoOutArray secondArray
  }


function file_saveState(){
  if [[ "$#" -ne 4 ]]; then
    echo "echoError insufficient arguments"
    echo "SENT ONLY $#"
  fi
  local fileLoc="$1"
  declare -n strVarsSent="$2";
  declare -n numVarsSent="$3";
  declare -n arraysSent="$4";

  local userInput=""

  if [[ -f "$fileLoc" ]]; then
    echo "" > "$fileLoc"
  else
    echo "echoError NO file found ----$fileLoc"
    echo "create the file ----$fileLoc----?"
    echo "??? y/n ????"
    read userInput
    if [[ "$userInput" == "y" ]]; then
      echo "" > "$fileLoc"
    else
      echoError "SAVE STATE ABORTED"
      return
    fi
  fi

  for thisVar in "${strVarsSent[@]}"; do
    echo "$thisVar=\"${!thisVar}\""
  done >> "$fileLoc"

  for thisVar in "${numVarsSent[@]}"; do
    echo "$thisVar=${!thisVar}"
  done >> "$fileLoc"

  local counter=0
  for thisArray in "${arraysSent[@]}"; do
    echo "$thisArray=()"
    declare -n testArray="${thisArray[@]}"
    # echo "testArray length is ${#testArray[@]}"
    counter=0
    for thisVar in "${testArray[@]}"; do
      # echo "thisVar is $thisVar"
      echo "$thisArray[$counter]=\"$thisVar\""
      ((counter++))
    done
  done >> "$fileLoc"
  # > whateverthefuck.txt
}
  function file_saveState_example(){

    declare -a firstArray=("firstArray man" "second Element")
    declare -a blankArray=()
    declare -a secondArray=("holy" "fuck" "secondArray")
    declare -n renameArray=secondArray
    # declare -a arrays=("firstArray" "blankArray" "secondArray")
    declare -a arrays=("firstArray" "blankArray" "secondArray" "renameArray")

    local var1="var 1 thingy"
    local var2="second var"
    local var3=3
    declare -a stringVars=("var1" "var2")
    declare -a numberVars=("var3")

    file_saveState "./_saveStates/_EXAMPLE_TEST.txt" stringVars numberVars arrays
    # readState
  }

##############################
# END OF COPY COREFNCS
##############################
