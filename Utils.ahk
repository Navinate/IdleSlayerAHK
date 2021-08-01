#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force

ClickAt(X, Y, Delay := 50, Hold := 50)
{
    MouseMove X, Y, 0
    Click Down
    Sleep Hold
    Click Up
    Sleep Delay
}

PressSpace(Hold := 20)
{
    Send {Space Down}
    Sleep Hold
    Send {Space Up}
}

PressShift(Hold := 20)
{
    Send {Shift Down}
    Sleep Hold
    Send {Shift Up}
}
