; Name: Battlefield 3 sprint toggle
; Version: 1.0
; Author: Jonathon Rogers <lonepie@gmail.com>
; URL: http://code.google.com/p/bunchafunk/downloads/
; AutoHotkey Version: 1.0.48.05
; Language: English
;
; Script Function:
;   Enhanced sprint for "Battlefield 3"
; Required File(s):
;	bf3_sprint_toggle-config.ini
;
;*******************************************************************************
;				Settings					
;*******************************************************************************
#NoEnv
#SingleInstance force
#MaxThreadsPerHotkey 1
#InstallKeybdHook
#InstallMouseHook

SendMode Input
SetWorkingDir %A_ScriptDir%

OnExit, ScriptToggle

VERSION = 1.0
SRC_URL := "http://bunchafunk.googlecode.com/svn/trunk/bf3_sprint_toggle"
DEBUG := false

;*******************************************************************************
;				Tray Settings					
;*******************************************************************************
TrayTip, Bunchafunk's BF3 AutoHotkey Script v%VERSION%, This script will continue to run in the system tray until closed manually.
Menu, Tray, MainWindow
Menu, Tray, Tip, Bunchafunk's BF3 AutoHotkey Script v%VERSION%
Menu, Tray, add
Menu, Tray, add, About, AboutDlg
Menu, Tray, add, Check for Updates, CheckForUpdates

;*******************************************************************************
;				Variables					
;*******************************************************************************
scriptState := true
crouchState := false
sprintState := false
aimState := false
lastSpot := 0
fwd_presses := 0

;*******************************************************************************
;				Load Preferences				
;*******************************************************************************
;IniRead, EnableCrouchToggle, bf3_sprint_toggle-config.ini, General, EnableCrouchToggle
IniRead, EnableSprintToggle, bf3_sprint_toggle-config.ini, General, EnableSprintToggle
;IniRead, EnableAimHoldToggle, bf3_sprint_toggle-config.ini, General, EnableAimHoldToggle
IniRead, EnableAutoSpot, bf3_sprint_toggle-config.ini, General, EnableAutoSpot
IniRead, AutoSpotCooldown, bf3_sprint_toggle-config.ini, General, AutoSpotCooldown
IniRead, BeepOnScriptToggle, bf3_sprint_toggle-config.ini, General, BeepOnScriptToggle
IniRead, SuspendOnChat, bf3_sprint_toggle-config.ini, General, SuspendOnChat
IniRead, SuspendOnSteamOverlay, bf3_sprint_toggle-config.ini, General, SuspendOnSteamOverlay
IniRead, CheckForUpdatesOnStartup, bf3_sprint_toggle-config.ini, General, CheckForUpdatesOnStartup

IniRead, k_ScriptToggle, bf3_sprint_toggle-config.ini, Hotkeys, ScriptToggle
;IniRead, k_CrouchToggle, bf3_sprint_toggle-config.ini, Hotkeys, CrouchToggle
;IniRead, k_AimHold, bf3_sprint_toggle-config.ini, Hotkeys, AimHold

IniRead, g_Crouch, bf3_sprint_toggle-config.ini, Keybinds, Crouch
IniRead, g_Forward, bf3_sprint_toggle-config.ini, Keybinds, Forward
IniRead, g_Sprint, bf3_sprint_toggle-config.ini, Keybinds, Sprint
IniRead, g_Aim, bf3_sprint_toggle-config.ini, Keybinds, Aim
IniRead, g_Jump, bf3_sprint_toggle-config.ini, Keybinds, Jump
IniRead, g_ChatAll, bf3_sprint_toggle-config.ini, Keybinds, ChatAll
IniRead, g_ChatTeam, bf3_sprint_toggle-config.ini, Keybinds, ChatTeam
IniRead, g_ChatSquad, bf3_sprint_toggle-config.ini, Keybinds, ChatSquad
IniRead, g_Fire, bf3_sprint_toggle-config.ini, Keybinds, Fire
IniRead, g_Spot, bf3_sprint_toggle-config.ini, Keybinds, Spot
IniRead, g_Reload, bf3_sprint_toggle-config.ini, Keybinds, Reload
IniRead, g_Melee, bf3_sprint_toggle-config.ini, Keybinds, Melee
IniRead, g_FirstWeapon, bf3_sprint_toggle-config.ini, Keybinds, FirstWeapon
IniRead, g_SecondWeapon, bf3_sprint_toggle-config.ini, Keybinds, SecondWeapon
IniRead, g_ThirdWeapon, bf3_sprint_toggle-config.ini, Keybinds, ThirdWeapon
IniRead, g_FourthWeapon, bf3_sprint_toggle-config.ini, Keybinds, FourthWeapon
IniRead, g_NextWeapon, bf3_sprint_toggle-config.ini, Keybinds, NextWeapon
IniRead, g_PrevWeapon, bf3_sprint_toggle-config.ini, Keybinds, PrevWeapon
IniRead, g_SteamOverlay, bf3_sprint_toggle-config.ini, Keybinds, SteamOverlay

;crouchToggleSameKey := (k_CrouchToggle = g_Crouch)
;aimHoldSameKey := (k_AimHold = g_Aim)

;*******************************************************************************
;				Hotkeys						
;*******************************************************************************
HotKey *%k_ScriptToggle%, ScriptToggle
;Hotkey, IfWinActive, ahk_class Battlefield 3
Hotkey, IfWinActive, ahk_class KeyboardTest
; only allow these hotkeys if "Battlefield 3" window is active
/*
if EnableCrouchToggle
{
	if crouchToggleSameKey
		HotKey, %k_CrouchToggle%, CrouchToggle
	else
		Hotkey, *%k_CrouchToggle%, CrouchToggle
	Hotkey, ~*%g_Forward%, ForwardPress
	Hotkey, ~*%g_Jump%, Jump
	if not EnableSprintToggle
	{
		Hotkey, *%g_Sprint%, SprintHold
		Hotkey, *%g_Sprint% UP, SprintHold
	}
}
if !EnableCrouchToggle or !crouchToggleSameKey
{
	HotKey, *%g_Crouch%, CrouchHold
	HotKey, *%g_Crouch% UP, CrouchHold
}
*/
if EnableSprintToggle
{
	;Hotkey, ~%g_Forward% & %g_Sprint% UP, Sprint
	Hotkey, *%g_Sprint% UP, SprintToggle
	Hotkey, *%g_Melee%, Melee
}
/*
if EnableAimHoldToggle
{
	if aimHoldSameKey
		Hotkey, *%g_Aim%, AimHoldToggle
	else
		Hotkey, *%k_AimHold%, AimHoldToggle
}
else
{
	Hotkey, *%g_Aim%, AimHoldToggle
	;Hotkey, *~%g_Aim%, AimToggle
}
*/
if EnableAutoSpot
{
	HotKey, ~*%g_Fire%, AutoSpot
}
if SuspendOnChat
{
	Hotkey, ~*%g_ChatAll%, ChatToggle
	Hotkey, ~*%g_ChatTeam%, ChatToggle
	Hotkey, ~*%g_ChatSquad%, ChatToggle
}
if SuspendOnSteamOverlay
{
	Hotkey, ~*%g_SteamOverlay%, ScriptToggle
}

Hotkey, ~*%g_FirstWeapon%, SwitchWeapon
Hotkey, ~*%g_SecondWeapon%, SwitchWeapon
Hotkey, ~*%g_ThirdWeapon%, SwitchWeapon
Hotkey, ~*%g_FourthWeapon%, SwitchWeapon
Hotkey, ~*%g_NextWeapon%, SwitchWeapon
Hotkey, ~*%g_PrevWeapon%, SwitchWeapon
Hotkey, ~*%g_Reload%, SwitchWeapon

if CheckForUpdatesOnStartup
{
	GoSub, CheckForUpdates
}
DebugMsg("< Ready >")
return
;*******************************************************************************
;				Hotkey Labels					
;*******************************************************************************
ScriptToggle:
	Suspend, Permit
	if scriptState or A_ExitReason
	{
		Suspend, On
		scriptState := false
		GoSub, ResetStates
		/*
		if GetKeyState(g_Crouch) and EnableCrouchToggle
		{
			Send {%g_Crouch% up}
		}
		*/
		if GetKeyState(g_Sprint) and EnableSprintToggle
		{
			Send {%g_Sprint% up}
		}
		if A_ExitReason
		{
			DebugMsg("< Exiting : " . A_ExitReason . " >")
			ExitApp
		}
		else if BeepOnScriptToggle
			SoundBeep
	}
	else
	{
		Suspend, Off
		scriptState := true
		if BeepOnScriptToggle
			SoundBeep, 750
	}
	DebugMsg("ScriptToggle => " . scriptState)
	return

ChatToggle:
	Suspend, Permit
	if scriptState
	{
		Suspend, On
		scriptState := false
		GoSub, ResetStates
		/*
		if GetKeyState(g_Crouch) and EnableCrouchToggle
		{
			Send {%g_Crouch% up}
		}
		*/
		if GetKeyState(g_Sprint) and EnableSprintToggle
		{
			Send {%g_Sprint% up}
		}
		Keywait, Enter, D ; wait for ENTER to be pressed
		Suspend, Off
		scriptState := true
	}
	return

ResetStates:
	aimState := false
	sprintState := false
	crouchState := false
	return

	/*
Jump:
	if crouchState
		GoSub, CrouchToggle
	return

CrouchToggle:
	if scriptState and EnableCrouchToggle
	{
		if crouchState
		{
			Send {%g_Crouch% up}
		}
		else 
		{
			Send {%g_Crouch% down}
			sprintState := false
		}
		crouchState := !crouchState
		DebugMsg("CrouchToggle => " . crouchState)
	}
	return
	*/

SprintToggle:
	if scriptState and EnableSprintToggle
	{
		if (!GetKeyState(g_Forward, "P"))
			return

		if !sprintState
		{
			/*
			if (crouchState)
			{
				GoSub, CrouchToggle
			}
			if (aimState)
			{
				GoSub, AimHoldToggle
				sleep 25 ; let the game catch up
			}
			*/

			sprintState := true
			Send {%g_Sprint% down}
			DebugMsg("SprintToggle => On")
			while GetKeyState(g_Forward,"P")
			{
				if (crouchState or aimState or not sprintState)
				{
					DebugMsg("sprint stopped by state change")
					break
				}
				if GetKeyState(g_Crouch)
				{
					;DebugMsg("sprint stopped by crouch")
					break
				}
				if GetKeyState(g_Sprint, "P")
				{
					;DebugMsg("sprint pressed, waiting for release...")
					Keywait, %g_Sprint%
					;DebugMsg("sprint released, breaking")
					break
				}
				sleep 50 ; prevents high cpu usage
			}
			if (GetKeyState(g_Sprint) and not GetKeyState(g_Sprint, "P"))
				Send {%g_Sprint% up}
			sprintState := false
			DebugMsg("SprintToggle => Off")
			sleep 100
		}
	}
	return

Melee:
	if scriptState
	{
		if sprintState
		{
			sprintState := false
			sleep 50
		}
		Send {%g_Melee%}
	}
	return

	/*
AimHoldToggle:
	if scriptState
	{
		aimState := !aimState
		if aimState and sprintState 
		{
			DebugMsg("aim while sprinting, stop sprinting")
			sprintState := false
		}
		Send {%g_Aim%}
		DebugMsg("AimHoldToggle => " . aimState)
		sleep 25
		if (aimState and GetKeyState(k_AimHold, "P") and EnableAimHoldToggle)
		{
			DebugMsg("waiting for aim to be released")
			KeyWait, %k_AimHold%
			if aimState
			{
				; another thread may have released aim already
				Send {%g_Aim%}
				aimState := false
				DebugMsg("aim released, stopped aiming")
				sleep 100
			}
		}
	}
	return
	*/

	/*
CrouchHold:
	if scriptState
	{
		if (GetKeyState(g_Crouch, "P") and not crouchState)
		{
			Send {%g_Crouch% down}
			crouchState := true
			DebugMsg("CrouchHold => Down")
		}
		else if (crouchState and not GetKeyState(g_Crouch, "P"))
		{
			Send {%g_Crouch% up}
			crouchState := false
			DebugMsg("CrouchHold => Up")
		}
		sleep 100
	}
	return
	*/

	/*
SprintHold:
	if scriptState
	{
		if (GetKeyState(g_Sprint, "P") and not sprintState)
		{
			if aimState
				GoSub, AimHoldToggle
			if crouchState
				GoSub, CrouchToggle
			if (!crouchState and !aimState)
			{
				Send {%g_Sprint% down}
				sprintState := true
				DebugMsg("SprintHold => Down")
			}
		}
		else if (sprintState and not GetKeyState(g_Sprint, "P"))
		{
			if (GetKeyState(g_Sprint))
				Send {%g_Sprint% up}
			sprintState := false
			DebugMsg("SprintHold => Up")	
		}
		sleep 100
	}
	return
	*/

	/*
ForwardPress:
	if scriptState
	{
		if (fwd_presses > 0)
		{
			;DebugMsg("ForwardPress => " . fwd_presses)
			if (A_ThisHotkey = A_PriorHotkey and ( A_TimeSincePriorHotkey > 50 and A_TimeSincePriorHotkey < 220 ))
			{
				DebugMsg("time since prior: " . A_TimeSincePriorHotkey)
				fwd_presses += 1
			}
			return
		}

		fwd_presses = 1
		SetTimer, DoubleForwardSprint, 180
	}
	return
	*/
	
	/*
DoubleForwardSprint:
	SetTimer, DoubleForwardSprint, off
	if fwd_presses = 2
	{
		DebugMsg("DoubleForwardSprint => On")
		;if crouchState
			;GoSub, CrouchToggle
		;if aimState
			;GoSub, AimHoldToggle

		if !crouchState
		{
			sprintState := true
			KeyWait, %g_Forward%
			sprintState := false
		}
		DebugMsg("DoubleForwardSprint => Off")
	}
	fwd_presses = 0
	return
	*/

AutoSpot:
	if scriptState and EnableAutoSpot
	{
		if AutoSpotCooldown
		{
			while(GetKeyState(g_Fire, "P"))
			{
				if ((A_TickCount - lastSpot >= 1000) or lastSpot = 0)
				{
					Send {%g_Spot%}
					lastSpot := A_TickCount
					DebugMsg("AutoSpot => " . lastSpot)
				}
				sleep 50
			}
		}
		else
		{
			Send {%g_Spot%}
			sleep 50
		}
	}
	return

SwitchWeapon:
	if scriptState
	{
		if sprintState
			sprintState := false
		;if aimState
			;aimState := false
	}
	return

;*******************************************************************************
;				GUI: Check for Updates		
;*******************************************************************************
CheckForUpdates:
	UrlDownloadToFile, %SRC_URL%/CHANGELOG.txt, tmp_changelog.txt
	if not ErrorLevel
	{
		FileReadLine, LATEST, tmp_changelog.txt, 1
		if not ErrorLevel
		{
			StringTrimRight, LATEST, LATEST, 1
			if (LATEST != VERSION and LATEST > VERSION)
			{
				FileRead, CHANGELOG, tmp_changelog.txt

				; build GUI 
				Gui, font, bold
				Gui, Add, Text, xm ym , An updated version of this script has been detected.
				Gui, font, cRed italic
				Gui, Add, Text, w200 , Your Version: %VERSION%
				Gui, font, cGreen
				Gui, Add, Text, y+5 w200, Latest Version: %LATEST%
				Gui, font, cDefault norm bold
				Gui, Add, Text,  , Changelog:
				Gui, font, norm, Courier New
				Gui, Add, Edit, w380 r20 ReadOnly vEditChangelog, 
				Gui, font, ,
				Gui, Add, Text,  , Download the latest version?
				Gui, Add, Button, x242 y400 w70 h30 default gButtonDownloadOk , OK
				Gui, Add, Button, x322 y400 w70 h30 gButtonDownloadCancel , Cancel

				Gui, Show, AutoSize, Check for Updates
				GuiControl, , EditChangelog, %CHANGELOG%
			}
			FileDelete, tmp_changelog.txt
		}
	}
	return

ButtonDownloadOk:
	MsgBox, 64, Continue, Press OK to close script and download update using your browser.
	Run, http://bunchafunk.googlecode.com/files/crouch_aim_toggle_v2.zip
	;Run, http://www.autohotkey.net/~bunchafunk/crouch_aim_toggle_v2.zip ;alternate download URL
	ExitApp
return

ButtonDownloadCancel:
	Gui, Destroy
return

AboutDlg:
	MsgBox, 64, About, Author: Jonathon Rogers <lonepie@gmail.com>`nURL: http://code.google.com/p/bunchafunk`nVersion: %VERSION%
return

DebugMsg(StrMsg)
{
	global DEBUG
	if (DEBUG)
	{
		OutputDebug, %StrMsg%
	}
	return
}
