echo "FINDING DEVICES NOW"


# GLOBAL VARIABLES USED
rmb_driveInfo_rootDevices=()

function rmb_driveInfo(){
  lsblk
}



rmb_driveInfo_knownMachineIDs=("f9a1a119b09f426e9a1134d64cad9df8" "afa461b3d2e44713a37cea92d3908b4f")
rmb_driveInfo_knownMachineIDs_names=("c302" "rp3bp")

rmb_driveInfo_findMachineID_RETURN_foundMachineID=""
rmb_driveInfo_findMachineID_RETURN_foundMachineID_name=""
function rmb_driveInfo_findMachineID(){

  rmb_driveInfo_findMachineID_RETURN_foundMachineID=""
  rmb_driveInfo_findMachineID_RETURN_foundMachineID_name=""
  local found_machineID=""
        found_machineID=$(hostnamectl | grep Machine)
        found_machineID=${found_machineID#*ID:\ }

  echo "found_machineID is ---$found_machineID"
  rmb_driveInfo_findMachineID_RETURN_foundMachineID="$found_machineID"

  rmb_kfl_findKey "$found_machineID" rmb_driveInfo_knownMachineIDs
  #  echo "SEARCHING ---$rmb_kfl_findkey_RETURN"
  if [[ "$rmb_kfl_findKey_RETURN" -ne -1 ]]; then
  #    echo "FOUND SHIT YO ---$rmb_kfl_findkey_RETURN"
    rmb_driveInfo_findMachineID_RETURN_foundMachineID_name="${rmb_driveInfo_knownMachineIDs_names[$rmb_kfl_findKey_RETURN]}"
  #    echo "name is $rmb_driveInfo_findMachineID_RETURN_foundMachineID_name"
  fi

  echo "rmb_driveInfo_findMachineID_RETURN_foundMachineID is  ---$rmb_driveInfo_findMachineID_RETURN_foundMachineID"
  echo "rmb_driveInfo_findMachineID_RETURN_foundMachineID_name is  ---$rmb_driveInfo_findMachineID_RETURN_foundMachineID_name"

}




rmb_driveInfo_knownDrives_serials=("0xb093b77a" "0xe05b618e")
rmb_driveInfo_knownDrives_names=("c302" "rp3bp")

rmb_driveInfo_findMainDrive_RETURN_foundDrives=()
rmb_driveInfo_findMainDrive_RETURN_foundDrives_serials=()
rmb_driveInfo_findMainDrive_RETURN_foundDrives_names=()
function rmb_driveInfo_findMainDrive(){

  rmb_driveInfo_findMainDrive_RETURN_foundDrives=()
  rmb_driveInfo_findMainDrive_RETURN_foundDrives_serials=()
  rmb_driveInfo_findMainDrive_RETURN_foundDrives_serials=()

  declare -a namesToSearchFor=("mmcblk0" "sda")
  
  local searchName=""
  for searchName in "${namesToSearchFor[@]}"; do
    lsblk -d | grep -q "$searchName"
    if [[ "$?" == 0 ]]; then
  #      echo "FOUND DRIVE MATCH --- $searchName"
      rmb_driveInfo_findMainDrive_RETURN_foundDrives+=("$searchName")
    fi
  done
  

  local dummy=""
  local serialFound=""
  for dummy in "${rmb_driveInfo_findMainDrive_RETURN_foundDrives[@]}"; do
  #    echo "SERIAL FOUNDS"
    udevadm info --query=all --name=/dev/mmcblk0 | grep ID_SERIAL
    if [[ "$?" == 0 ]]; then
      serialFound=$(udevadm info --query=all --name=/dev/mmcblk0 | grep ID_SERIAL)
  #      echo "first serialFound is $serialFound"
      serialFound=${serialFound#*ID_SERIAL=}
        echo "second serialFound is $serialFound"
      rmb_driveInfo_findMainDrive_RETURN_foundDrives_serials+=("$serialFound")
    fi
  done

  
  local count=0
  for dummy in "${rmb_driveInfo_findMainDrive_RETURN_foundDrives_serials[@]}"; do
    rmb_kfl_findKey "$dummy" rmb_driveInfo_knownDrives_serials
    if [[ "$rmb_kfl_findkey_RETURN" -ne -1 ]]; then
      rmb_driveInfo_findMainDrive_RETURN_foundDrives_names[$count]="${rmb_driveInfo_knownDrives_names[$count]}"
    else
      rmb_driveInfo_findMainDrive_RETURN_foundDrives_names[$count]=""
    fi
    ((count++))
  done

  echo "first entry in drives is ${rmb_driveInfo_findMainDrive_RETURN_foundDrives[0]}"
  echo "first entry in serials is ${rmb_driveInfo_findMainDrive_RETURN_foundDrives_serials[0]}"
  echo "first entry in names is ${rmb_driveInfo_findMainDrive_RETURN_foundDrives_names[0]}"


}

#rmb_driveInfo_findMainDrive
#rmb_driveInfo_findMachineID
