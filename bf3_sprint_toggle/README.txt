AUTHOR:
-------------
Jonathon Rogers
lonepie@gmail.com
http://code.google.com/p/bunchafunk

DESCRIPTION:
-------------
Implements the following functionality in BF3:
Crouch Toggle
Sprint Toggle
Hold to Aim-Down-Sight

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
CrouchToggle: press and release this key to toggle holding the Crouch key; can be the same key as Crouch
SprintToggle: while holding FORWARD, press the SPRINT key to start sprinting. You will stop sprinting if: FORWARD is released, SPRINT is pressed, Crouch is toggled
Aim-Down-Sight Hold: aim-down-sight as long as this button is held down; spriting will also cancel.

NOTES:
-------------
The script has no way of knowing the player's state ingame.
Example: if you die while Crouch is toggled on, it will remain on until you press the CrouchToggle button again.

Do not confuse this script's bf3_sprint_toggle-config.ini file with the one used by BF3!
bf3_sprint_toggle-config.ini:
 - The [Hotkeys] section refers to key configuration for use by this script only
 - The [Keybinds] section is where you tell the script what your INGAME keybinds are; make sure these match your setup

CHANGELOG:
-------------
See CHANGELOG.txt

KNOWN ISSUES:
-------------
	- In Windows Vista or Windows 7, you may need to use "run as administrator" on the script.
		See details here: http://www.howtogeek.com/howto/windows-vista/add-run-as-administrator-for-autohotkey-scripts-in-windows-vista/
	- When "EnableAimHoldToggle" is enabled:
		The aim/zoom state will get reversed if you continue holding the Aim button through a weapon reload animation. Repeat to un-reverse.
	- By default, "CrouchToggle" is set to the "c" key, which will break the "Change Camera" binding in-game. Change either binding depending on your preference.
	- If using "EnableSpotOnFire=1" and "Fire=LButton", clicking at any time will send the "Spot" key, even in the game's menu. Use "ScriptToggle" (default: F12) to toggle the script on/off, as needed.
