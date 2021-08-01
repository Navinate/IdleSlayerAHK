#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force

ClickAt(X, Y, Delay := 500)
{
    MouseMove X, Y, 0
    Click
    Sleep Delay
}

PressSpace(Delay := 20)
{
    Send {Space Down}
    Sleep Delay
    Send {Space Up}
}

PressShift(Delay := 20)
{
    Send {Shift Down}
    Sleep Delay
    Send {Shift Up}
}
