# global declarations

rmb_SETTING_fileBrowser="pcmanfm"
rmb_SETTING_webBrowser="chromium-browser"
rmb_SETTING_textEditorGeneral="bluefish"
rmb_SETTING_textEditorImportant="nano"

function rmb_SETTINGS_testPrograms(){

	# TESTING THE CALLS OF PROGRAMS
	#"$rmb_SETTING_fileBrowser" # calls and returns
	"$rmb_SETTING_webBrowser" # calls but waits for close
}

function rmb_SETTINGS_testIfProgInstalled(){

	which "$rmb_SETTING_textEditorImportant"
	# if this returns something - then its installed
	# -NOT FINISHED
}

rmb_SETTINGS_test