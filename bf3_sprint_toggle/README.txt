AUTHOR:
-------------
Jonathon Rogers
lonepie@gmail.com
https://github.com/lonepie/bunchafunk

DESCRIPTION:
-------------
Implements the following functionality in BF3:
Sprint Toggle
Automatically "Spot" enemies when you fire at them

INSTALL:
-------------
If you have AutoHotkey installed, simply double-click bf3_sprint_toggle.ahk to run the script.
Otherwise, run the bf3_sprint_toggle.exe file.

The script will continue to run in the background until manually closed (or system shutdown/reboot/logoff).
To manually close the script: right-click the white-on-green "H" icon in the systray and click "Exit".

USAGE:
-------------
Edit the bf3_sprint_toggle-config.ini file to enable/disable script functionality and map your keybindings.

ScriptToggle: enable/disable the entire script
SprintToggle: while holding FORWARD, press the SPRINT key to start sprinting. You will stop sprinting if: FORWARD is released, SPRINT is pressed, Crouch is toggled

CONFIG:
-------------
bf3_sprint_toggle-config.ini:
 - The [Hotkeys] section refers to key configuration for use by this script only
 - The [Keybinds] section is where you tell the script what your INGAME keybinds are; make sure these match your setup

CHANGELOG:
-------------
See CHANGELOG.txt

KNOWN ISSUES:
-------------
	- In Windows Vista or Windows 7, you may need to use "run as administrator" on the script. See details here: http://www.howtogeek.com/howto/windows-vista/add-run-as-administrator-for-autohotkey-scripts-in-windows-vista/
	- If using "EnableSpotOnFire=1" and "Fire=LButton", clicking at any time will send the "Spot" key, even in the game's menu. Use "ScriptToggle" (default: F12) to toggle the script on/off, as needed.
