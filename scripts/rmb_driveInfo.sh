echo "FINDING DEVICES NOW"


# GLOBAL VARIABLES USED
rmb_driveInfo_rootDevices=()

function rmb_driveInfo(){
  lsblk
}




rmb_driveInfo_findRootSerial_RETURN_foundDrives=()
rmb_driveInfo_findRootSerial_RETURN_foundDrives_serials=()
function rmb_driveInfo_findRootSerial(){

  rmb_driveInfo_findRootSerial_RETURN_foundDrives=()
  rmb_driveInfo_findRootSerial_RETURN_foundDrives_serials=()

  declare -a namesToSearchFor=("mmcblk0" "sda")
  
  local searchName=""
  for searchName in "${namesToSearchFor[@]}"; do
    lsblk -d | grep -q "$searchName"
    if [[ "$?" == 0 ]]; then
      echo "FOUND DRIVE MATCH --- $searchName"
      rmb_driveInfo_findRootSerial_RETURN_foundDrives+=("$searchName")
    fi
  done
  

  local dummy=""
  local serialFound=""
  for dummy in "${rmb_driveInfo_findRootSerial_RETURN_foundDrives[@]}"; do
    echo "SERIAL FOUNDS"
    udevadm info --query=all --name=/dev/mmcblk0 | grep ID_SERIAL
    if [[ "$?" == 0 ]]; then
      serialFound=$(udevadm info --query=all --name=/dev/mmcblk0 | grep ID_SERIAL)
      echo "first serialFound is $serialFound"
      serialFound=${serialFound#*ID_SERIAL=}
      echo "second serialFound is $serialFound"
      rmb_driveInfo_findRootSerial_RETURN_foundDrives_serials+=("$serialFound")
    fi
  done
   echo "first entry in drives is ${rmb_driveInfo_findRootSerial_RETURN_foundDrives[0]}"
   echo "first entry in serials is ${rmb_driveInfo_findRootSerial_RETURN_foundDrives_serials[0]}"

}

rmb_driveInfo_findRootSerial