;
; AutoHotkey Version: 1.x
; Language:       English
; Author:         Jonathon Rogers <lonepie@gmail.com>
;
; Script Function:
;   "Modern Warfare 2"-like toggle crouch and toggle sprint for "Battlefield: Bad Company 2"
;	Also added "hold" functionality to aiming.

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

;*******************************************************************************
;				Variables					
;*******************************************************************************
scriptState := true
crouchState := false
sprintState := false
aimState := false

;*******************************************************************************
;				Load Preferences				
;*******************************************************************************
;IniRead, EnableCrouchToggle, bf3_sprint_toggle-config.ini, General, EnableCrouchToggle
IniRead, EnableSprintToggle, bf3_sprint_toggle-config.ini, General, EnableSprintToggle
;IniRead, EnableAimHoldToggle, bf3_sprint_toggle-config.ini, General, EnableAimHoldToggle
IniRead, BeepOnScriptToggle, bf3_sprint_toggle-config.ini, General, BeepOnScriptToggle
IniRead, SuspendOnChat, bf3_sprint_toggle-config.ini, General, SuspendOnChat

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

;crouchToggleSameKey := (k_CrouchToggle = g_Crouch)
;aimHoldSameKey := (k_AimHold = g_Aim)

;*******************************************************************************
;				Hotkeys						
;*******************************************************************************
HotKey *%k_ScriptToggle%, ScriptToggle
Hotkey, IfWinActive, ahk_class Battlefield 3
; only allow these hotkeys if "Battlefield 3" window is active
/*
if EnableCrouchToggle
{
	if crouchToggleSameKey
		HotKey, $%k_CrouchToggle%, CrouchToggle
	else
		Hotkey, ~*%k_CrouchToggle%, CrouchToggle
}
*/
if EnableSprintToggle
	Hotkey, ~%g_Forward% & %g_Sprint% UP, Sprint
/*
if EnableAimHoldToggle
{
	if aimHoldSameKey
	{
		Hotkey, *$%g_Aim%, AimHoldToggle
		;HotKey, *$%g_Aim% UP, AimHoldToggle
	}
	else
	{
		Hotkey, *%k_AimHold%, AimHoldToggle
		;Hotkey, *%k_AimHold% UP, AimHoldToggle
	}
}
*/
if SuspendOnChat
{
	Hotkey, ~*%g_ChatAll%, ChatToggle
	Hotkey, ~*%g_ChatTeam%, ChatToggle
	Hotkey, ~*%g_ChatSquad%, ChatToggle
}
Hotkey, ~%g_Jump%, Jump
return
;*******************************************************************************
;				Hotkey Labels					
;*******************************************************************************
ScriptToggle:
	Suspend
	if scriptState or A_ExitReason
	{
		if GetKeyState(g_Crouch)
			Send {%g_Crouch% up}
		if GetKeyState(g_Sprint)
			Send {%g_Sprint% up}
		if A_ExitReason
			ExitApp
		else if BeepOnScriptToggle
			SoundBeep
	}
	else
	{
		if BeepOnScriptToggle
			SoundBeep, 750
	}
	scriptState := !scriptState
	return

ChatToggle:
	Suspend
	if GetKeyState(g_Crouch)
		Send {%g_Crouch% up}
	if GetKeyState(g_Sprint)
		Send {%g_Sprint% up}
	scriptState := false
	Keywait, Enter, D ; wait for ENTER to be pressed
	Suspend
	scriptState := true
	return

Jump:
	if crouchState
		GoSub, CrouchToggle
	return

CrouchToggle:
	if scriptState and EnableCrouchToggle
	{
		if crouchState
			Send {%g_Crouch% up}
		else
			Send {%g_Crouch% down}
		crouchState := !crouchState
	}
	return

Sprint:
	if scriptState and EnableSprintToggle
	{
		if !sprintState
		{
			if crouchState
				GoSub, CrouchToggle
			if aimState
				GoSub, AimHoldToggle

			sprintState := true
			Send {%g_Sprint% down}
			while GetKeyState(g_Forward,"P") and not GetKeyState(g_Sprint, "P") and sprintState
			{
				if (crouchState or aimState)
					break
				if GetKeyState(g_Crouch)
					break
				sleep 100 ; prevents high cpu usage
			}
			if GetKeyState(g_Sprint)
				Send {%g_Sprint% up}
			sprintState := false
			sleep 150
		}
	}
	return

AimHoldToggle:
	if scriptState and EnableAimHoldToggle
	{
		if sprintState
			sprintState := false
		Send {%g_Aim%}
		aimState := !aimState
		if aimState
		{
			KeyWait, %k_AimHold%
			Send {%g_Aim%}
			aimState := !aimState
		}
		sleep 100
	}
	return
