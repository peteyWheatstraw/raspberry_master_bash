git_SETTING_repos=()
git_SETTING_repos_folder=()
git_SETTING_repos_url=()

git_SETTING_repos+=("raspberry")
git_SETTING_repos_folder+=("./")
git_SETTING_repos_url+=("https://github.com/peteyWheatstraw/raspberry_master_bash.git")

git_SETTING_repos+=("master_bash")
git_SETTING_repos_folder+=("../master_bash/" )
git_SETTING_repos_url+=("https://github.com/peteyWheatstraw/masterbash.git")





##############################
# USED GLOBAL VARS
#####################################
git_sentPWD=""
git_gitFolder=""
#################################
# 
#################################

git_gitFolder_set(){
	if [[ "$#" -ne 1 ]]; then
		echo "ERROR - git-set-gitFolder - incorrect amount of arguments"
		return
	fi
	
	local newFolder="$1"
	if [[ -d "$newFolder" ]]; then
		git_gitFolder_check "$newFolder"
		if [[ "$git_gitFolder_check_RETURN" -eq 1 ]]; then
			git_gitFolder="$newFolder"
			echo "git_gitFolder SET TO ---$git_gitFolder---"
		fi
	else
		echo "ERROR - git_gitFolder_set - NOT A FOLDER  ---$newFolder"
	fi
}

git_test(){

	ls | grep whatever
	if [[ "$?" == 0 ]]; then
		echo "whatever match"
	else
		echo "no match"
	fi
#	echo "TEST"
#	echo "PWD IS ---$PWD"
#	echo "now changing directories"
#	cd /home/pi/Downloads/_euts/coding/bash/
#	echo "PWD NOW IS ---$PWD"
}

git_init(){
	git_sentPWD="$PWD"	
	echo "git sent pwd is $git_sentPWD"
	
	git_menu	
}

function git_gitFolder_download(){
	git_gitFolder_check "$git_gitFolder"
	if [[ "$git_gitFolder_check_RETURN" -ne 1 ]]; then
		echo "ERROR - git_gitFolder_upload -NOT A GIT FOLDER ---$git_gitFolder"
		return
	fi	
	
	if [[ "$git_sentPWD" == "" ]]; then
		echo "ERROR - git_gitFolder_upload - sent PWD not set"
		return
	fi
	
	cd "$git_gitFolder"
	echo "attempting to pull master"
	git pull origin master | grep "fatal"
	if [[ "$?" == 0 ]]; then
		echo "ERROR - fatal error pulling git"
	fi
	cd "$git_sentPWD"
}

function git_menu(){
	declare -a git_menu_key=()
	declare -a git_menu_label=()
	declare -a git_menu_func=()
	
	local repo=""
	local count=0
	
	for repo in "${git_SETTING_repos[@]}"; do
		git_menu_key+=("u$count")
		git_menu_label+=("upload_$repo")
		git_menu_func+=("git_gitFolder_set \"${git_SETTING_repos_folder[$count]}\"; git_gitFolder_upload; echo \"after\" ")			
		
		git_menu_key+=("d$count")
		git_menu_label+=("download_$repo")
		git_menu_func+=("git_gitFolder_set \"${git_SETTING_repos_folder[$count]}\"; git_gitFolder_download; echo \"after\" ")			
		
	#
	((count++))
	done

	git_menu_key+=("q")
	git_menu_label+=("quit")
	git_menu_func+=("echo 'quitting'; git_menu_exitLoop=1")	

	git_menu_key+=("t")
	git_menu_label+=("test")
	git_menu_func+=("git_test")	

	# git_menu_key+=()
	# git_menu_label+=()
	# git_menu_func+=()	
	
	
	git_menu_text(){
		local git_menu_counter=0
		echo "*********************************"
		echo "******    GIT MENU **************"
		echo "*********************************"
		while [[ "$git_menu_counter" -lt "${#git_menu_key[@]}" ]]; do
			echo "-${git_menu_key[$git_menu_counter]}---${git_menu_label[$git_menu_counter]}---"
			((git_menu_counter++))		
		done		
	}
	
	local git_menu_exitLoop=0
	local git_menu_input=""
	while [[ "$git_menu_exitLoop" -eq 0 ]]; do
		git_menu_text
		read git_menu_input
		echo "------------------------------------------------------"
		rmb_kfl_findKey "$git_menu_input"  git_menu_key
		if [[ "$rmb_kfl_findKey_RETURN" -ne -1 ]]; then
			eval "${git_menu_func[$rmb_kfl_findKey_RETURN]}"
		else
			echo "UNKNOWN COMMAND"
		fi
	
	done
}

git_gitFolder_check_RETURN=0
function git_gitFolder_check(){
	git_gitFolder_check_RETURN=0
	if [[ "$#" -lt 1 ]]; then
		echo "ERROR git_gitFolder_check"
		return
	else
		local gitFolder="$1"
	fi	
	if [[ -d "$gitFolder/.git" ]]; then
	#	echo "TIS A GIT FOLDER"
		git_gitFolder_check_RETURN=1
	else 
		echo "NOT a git folder"
	fi
}


function git_gitFolder_upload(){

	git_gitFolder_check "$git_gitFolder"
	if [[ "$git_gitFolder_check_RETURN" -ne 1 ]]; then
		echo "ERROR - git_gitFolder_upload -NOT A GIT FOLDER ---$git_gitFolder"
		return
	fi	
	
	if [[ "$git_sentPWD" == "" ]]; then
		echo "ERROR - git_gitFolder_upload - sent PWD not set"
		return
	fi
	
	cd "$git_gitFolder"
	
	
	git add -A
	local commitMessage=""
	echo "TYPE COMMIT MESSAGE NOW"
	read commitMessage
	git commit -m "$commitMessage"

	local trialExit=0
	#while [[ "$trialExit" 
	echo "attempting to pull master"
	git pull origin master | grep "fatal"
	if [[ "$?" == 0 ]]; then
		echo "ERROR - fatal error pulling git"
	else	
		echo "attempting to push master"
		git push origin master | grep "fatal"
		if [[ "$?" == 0 ]];then
			echo "ERROR - fatal error pushing git"
		fi
	fi
	cd "$git_sentPWD"
}

git_init