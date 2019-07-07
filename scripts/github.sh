
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
	
	git_addAll_commit_Pull_Push
	# git_check_gitFolder "$git_SETTING_gitFolder"
	
}


function git_menu(){
	echo "MENU"
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
	
	cd "$git_SETTING_sentPWD"
}

git_init