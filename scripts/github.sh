
#git_SETTING_gitFolder="./"
git_SETTING_gitFolder="/home/pi/Downloads/_euts/coding/bash/raspberry_master_bash/"

git_SETTING_sentPWD=""


# git_SETTING_urlRepos=("https://github.com/peteyWheatstraw/raspberry_master_bash.git")
# git_SETTING_urlRepos+=()

git_set_gitFolder(){
	if [[ "$#" -ne 1 ]]; then
		echo "ERROR - git-set-gitFolder - incorrect amount of arguments"
		return
	fi
	
	local newFolder="$1"
	if [[ -d "$newFolder" ]]; then
		git_check_gitFolder "$newFolder"
		if [[ "$git_check_gitFolder" -eq 1 ]]; then
			git_SETTING_gitFolder="$newFolder"
		fi
	else
		echo "ERROR - git_set_gitFolder - NOT A FOLDER  ---$newFolder"
	fi
}

git_init(){
	git_SETTING_sentPWD="$PWD"	
	echo "git sent pwd is $git_SETTING_sentPWD"
	
	# git_addAll_commit_Pull_Push
	git_menu
	# git_check_gitFolder "$git_SETTING_gitFolder"
	
}


function git_menu(){
	declare -a git_menu_key=()
	declare -a git_menu_label=()
	declare -a git_menu_func=()
	
	git_menu_key+=("ur")
	git_menu_label+=("upload Raspberry Master Bash")
	git_menu_func+=("git_addAll_commit_Pull_Push")	

	git_menu_key+=("q")
	git_menu_label+=("quit")
	git_menu_func+=("echo 'quitting'; git_menu_exitLoop=1")	

	
	
	git_menu_text(){
		local git_menu_counter=0

		while [[ "$git_menu_counter" -lt "${#git_menu_key[@]}" ]]; do
			echo "-${git_menu_key[$git_menu_counter]}---${git_menu_label[$textCounter]}---"
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

git_check_gitFolder_RETURN=0
function git_check_gitFolder(){
	git_check_gitFolder_RETURN=0
	if [[ "$#" -lt 1 ]]; then
		echo "ERROR git_check_gitFolder"
		return
	else
		local gitFolder="$1"
	fi	
	if [[ -d "$gitFolder/.git" ]]; then
		echo "TIS A GIT FOLDER"
		git_check_gitFolder_RETURN=1
	else
		echo "NOT A GIT FOLDER"
	fi
}

function git_addAll_commit_Pull_Push(){

	git_check_gitFolder "$git_SETTING_gitFolder"
	if [[ "$git_check_gitFolder_RETURN" -ne 1 ]]; then
		echo "ERROR - git_addAll_commit_pull_push -NOT A GIT FOLDER ---$git_SETTING_gitFolder"
	fi	
	
	if [[ "$git_SETTING_sentPWD" == "" ]]; then
		echo "ERROR - git_addAll_commit_pull_push - sent PWD not set"
	fi
	
	cd "$git_SETTING_gitFOlder"
	git add -A


	local commitMessage=""
	echo "TYPE COMMIT MESSAGE NOW"
	read commitMessage
	git commit -m "$commitMessage"

	git pull origin master
	git push origin master
	
	cd /home/pi
	#cd "$git_SETTING_sentPWD"
}

git_init