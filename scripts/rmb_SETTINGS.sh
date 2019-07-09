# global declarations

rmb_SETTING_varNames=()

#LOCATIONS

function rmb_SETTING_defaultVars_rp3bp(){


  # URLS
	rmb_SETTING_urlEuts="/home/pi/Downloads/_euts"
	rmb_SETTING_urlDownloads="/home/pi/Downloads"
	rmb_SETTING_urlRmb="/home/pi/Downloads/_euts/coding/bash/raspberry_master_bash"
  #	rmb_SETTING_urlSETTINGFile="$rmb_SETTING_urlRmb/_RMB_SETTING.txt"

  # PROGRAMS
	rmb_SETTING_webBrowser="chromium-browser"
	rmb_SETTING_fileBrowser="pcmanfm"
	rmb_SETTING_textEditorGeneral="bluefish"
	rmb_SETTING_textEditorImportant="nano"

  # COMPUTER DATA
	rmb_SETTING_operatingSystem="raspbian"
	rmb_SETTING_cpuArchitecture="arm"
  rmb_SETTING_hardDriveSerial="0xe05b618e"
}

function rmb_SETTING_defaultVars_c302(){

  # URLS
  rmb_SETTING_urlEuts="/home/petey/Downloads/_euts"
  rmb_SETTING_urlDownloads="/home/petey/Downloads"
  rmb_SETTING_urlRmb="/home/petey/Downloads/_euts/_coding/bash/raspberry_master_bash"
  #  rmb_SETTING_urlSETTINGFile="$rmb_SETTING_urlRmb/_RMB_SETTING.txt"

  # PROGRAMS
  rmb_SETTING_webBrowser="firefox"
  rmb_SETTING_fileBrowser="nautilus"
  rmb_SETTING_textEditorGeneral="subl"
  rmb_SETTING_textEditorImportant="nano"

  # COMPUTER DATA
  rmb_SETTING_operatingSystem="ubuntu"
  rmb_SETTING_cpuArchitecture="x86"
  rmb_SETTING_hardDriveSerial="0xb093b77a"
}

# URLS

rmb_SETTING_urlRmb=""
rmb_SETTING_varNames+=("rmb_SETTING_urlRmb")

rmb_SETTING_urlSETTINGFile=""
rmb_SETTING_varNames+=("rmb_SETTING_urlSETTINGFile")

rmb_SETTING_urlEuts=""
rmb_SETTING_varNames+=("rmb_SETTING_urlEuts")

rmb_SETTING_urlDownloads=""
rmb_SETTING_varNames+=("rmb_SETTING_urlDownloads")


# MAIN SETTING
	#PROGRAMS
rmb_SETTING_fileBrowser=""
rmb_SETTING_fileBrowser_opts=("pcmanfm" "nautilus")
rmb_SETTING_varNames+=("rmb_SETTING_fileBrowser")


rmb_SETTING_webBrowser=""
rmb_SETTING_webBrowser_opts=("chromium-browser" "firefox")
rmb_SETTING_varNames+=("rmb_SETTING_webBrowser")

rmb_SETTING_textEditorGeneral=""
rmb_SETTING_textEditorGeneral_opts=("bluefish" "subl")
rmb_SETTING_varNames+=("rmb_SETTING_textEditorGeneral")

rmb_SETTING_textEditorImportant=""
rmb_SETTING_textEditorImportant_opts=("nano")
rmb_SETTING_varNames+=("rmb_SETTING_textEditorImportant")

	#COMPUTER
rmb_SETTING_pcType=""
rmb_SETTING_pcType_opts=( "raspberry" "cindy" )
rmb_SETTING_varNames+=("rmb_SETTING_pcType")


rmb_SETTING_pcTypeCpu=""
rmb_SETTING_pcTypeCpu_opts=("arm" "x86")
rmb_SETTING_varNames+=("rmb_SETTING_pcTypeCpu")

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





function rmb_SETTING_test(){
	rmb_SETTING_readSETTINGFile
}

function rmb_SETTING_createSETTINGFile(){
		declare -a blankArrayOne=()
		declare -a blankArrayTwo=()
		
		file_saveState "$rmb_SETTING_urlSETTINGFile" rmb_SETTING_varNames blankArrayOne blankArrayTwo 
}

function rmb_SETTING_init(){
	rmb_SETTING_test
}

function rmb_SETTING_displaySETTING(){
   local whatever=""
   for whatever in "${rmb_SETTING_varNames[@]}"; do
   	echo "$whatever = ${!whatever}"
   done
}

function rmb_SETTING_readSETTINGFile(){
	if ! [[ -f "$rmb_SETTING_urlSETTINGFile" ]]; then
		rmb_SETTING_defaultVars_rp3bp
		rmb_SETTING_createSETTINGFile	
	fi
	
   file_loadState "$rmb_SETTING_urlSETTINGFile"
	rmb_SETTING_displaySETTING
}

function rmb_SETTING_testPrograms(){

	# TESTING THE CALLS OF PROGRAMS
	#"$rmb_SETTING_fileBrowser" # calls and returns
	"$rmb_SETTING_webBrowser" # calls but waits for close
}

function rmb_SETTING_testIfProgInstalled(){

	which "$rmb_SETTING_textEditorImportant"
	# if this returns something - then its installed
	# -NOT FINISHED
}

rmb_SETTING_init