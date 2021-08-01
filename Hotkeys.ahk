#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#MaxThreadsPerHotkey 3
#Include, GameScreen.ahk

F2::
    MsgBox % Floor(Round(0.2875 * 720 + 45, 10))
Return