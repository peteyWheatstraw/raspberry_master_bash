


rmb_templates_SETTING_urlTemplateFolder="./scripts/_templates"
# rmb_SETTING_varNames+=("rmb_templates_SETTING_urlTemplateFolder")



function rmb_templates_init(){
	
	# check if template folder makes sense
	if ! [[ -d "$rmb_templates_SETTING_urlTemplateFolder" ]]; then
		echo "ERROR ----rmb_templates_init---  template folder doesnt exist "
		echo "rmb_templates_SETTING_urlTemplateFolder=$rmb_templates_SETTING_urlTemplateFolder" 
		return
	else
		echo "template folder found"
	fi

	rmb_templates_findTemplates
	
}

rmb_templates_findTemplates_RETURN=()
function rmb_templates_findTemplates(){
	rmb_templates_findTemplates_RETURN=()
	echo "template folder is $rmb_templates_SETTING_urlTemplateFolder"
	while IFS= read -r -d $'\0'; do	
		echo "reply is $REPLY"
		rmb_templates_findTemplates_RETURN+=("$REPLY")
		echo "and a one two"		
		
	done < <(find "$rmb_templates_SETTING_urlTemplateFolder"* -name "template*" -prune -type f -print0)
	echo "first entry is ${rmb_templates_findTemplates_RETURN[0]}"
}

rmb_templates_init