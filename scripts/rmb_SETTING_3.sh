#echo "SETTINGS 2"

function encapsulated_NOTES(){


  removed the creating and editing of setting file

}

###################################
# DEFINED GLOBAL VARIABLES
##################################

#rmb_SETTING_varNames=()

# URLS

rmb_SETTING_urlEuts=""
rmb_SETTING_varNames+=("rmb_SETTING_urlEuts")

rmb_SETTING_urlDownloads=""
rmb_SETTING_varNames+=("rmb_SETTING_urlDownloads")

rmb_SETTING_urlRmb=""
rmb_SETTING_varNames+=("rmb_SETTING_urlRmb")

# MAIN SETTINGS
#PROGRAMS
rmb_SETTING_fileBrowser=""
rmb_SETTING_fileBrowser_opts=("pcmanfm" "nautilus")
rmb_SETTING_varNames+=("rmb_SETTING_fileBrowser")


rmb_SETTING_webBrowser=""
rmb_SETTING_webBrowser_opts=("chromium-browser" "firefox")
rmb_SETTING_varNames+=("rmb_SETTING_webBrowser")

rmb_SETTING_textEditorGeneral=""
rmb_SETTING_textEditorGeneral_opts=("bluefish" "subl" "geany")
rmb_SETTING_varNames+=("rmb_SETTING_textEditorGeneral")

rmb_SETTING_textEditorImportant=""
rmb_SETTING_textEditorImportant_opts=("nano")
rmb_SETTING_varNames+=("rmb_SETTING_textEditorImportant")

#COMPUTER DATA
rmb_SETTING_operatingSystem=""
rmb_SETTING_operatingSystem_opts=( "raspbian" "ubuntu" )
rmb_SETTING_varNames+=("operatingSystem")


rmb_SETTING_cpuArchitecture=""
rmb_SETTING_cpuArchitecture_opts=("arm" "x86")
rmb_SETTING_varNames+=("rmb_SETTING_cpuArchitecture")

rmb_SETTING_hardDriveSerial=""
rmb_SETTING_varNames+=("rmb_SETTING_hardDriveSerial")

rmb_SETTING_MachineId=""
rmb_SETTING_varNames+=("rmb_SETTING_MachineId")

#################################################
#  END OF DEFINED GLOBAL VARIABLES
#################################################


function rmb_SETTING_defaultVars_rp3bp(){


  # URLS
  rmb_SETTING_urlEuts="/home/pi/Downloads/_euts"
  rmb_SETTING_urlDownloads="/home/pi/Downloads"
  rmb_SETTING_urlRmb="/home/pi/Downloads/_euts/coding/bash/raspberry_master_bash"

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



function rmb_SETTING_test(){
	#rmb_SETTING_readSETTINGFile
  echo "rmb_SETTING_test"
}


function rmb_SETTING_init(){
	# source "./scripts/"
  rmb_SETTING_test
}

function rmb_SETTING_displaySETTING(){
   local whatever=""
   for whatever in "${rmb_SETTING_varNames[@]}"; do
   	echo "$whatever = ${!whatever}"
   done
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

#################################################
#  OLD CODE
#################################################

function OLD_rmb_SETTING_createSETTINGFile(){
    declare -a blankArrayOne=()
    declare -a blankArrayTwo=()
    
    file_saveState "$rmb_SETTING_urlSETTINGFile" rmb_SETTING_varNames blankArrayOne blankArrayTwo 
}

function OLD_rmb_SETTING_readSETTINGFile(){
  if ! [[ -f "$rmb_SETTING_urlSETTINGFile" ]]; then
    rmb_SETTING_defaultVars_rp3bp
    rmb_SETTING_createSETTINGFile 
  fi
  
   file_loadState "$rmb_SETTING_urlSETTINGFile"
  rmb_SETTING_displaySETTING
}


rmb_SETTING_init
