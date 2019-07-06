function locale_getLocaleSettings(){
	locale
}

function locale_seeAvailableLocales(){
	local -a|more
}

function locale_generateLocales(){
	echo "first uncomment the locales you want to generate "

	sudo nano /etc/locale.gen
	echo "generating those locales maaaan"
	sudo locale-gen
}

function locale_updateLocale(){
	if [[ "$#" -lt 2 ]]; then
		echo "ERROR!!!! ---locale_updateLocale ----OH FUCK SON"
	else
		local localeKeyToSet="$1"
		local localeValueToSet="$2"
	fi	
	
	local settingToClear=""
	if [[ "$#" -eq 3 ]]; then
		settingToClear="$3"
	fi
	
	# declare -a settingsToClear=()
	
	# should check to make sure that newDefault 
	# exists in the available - 
	# if not - generate it but whatever
	
	# NOT TESTED
	echo "NOT TESTED"
	
	#sudo update-locale LANG=en_US.UTF-8 LANGUAGE
	sudo update-locale "$localeKeyToSet"="$localeValueToSet" "$settingToClear"	
}