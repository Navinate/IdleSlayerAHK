#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force

ClickAt(X, Y, Delay := 50)
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

Jump(Delay := 20, Shots := 35)
{
    PressSpace(Delay)

    Loop %Shots%
        ShootBow()
}

LowJump(Shoot := False)
{
    Shots := Shoot ? 35 : 0
    Jump(20, Shots)
}

MediumJump(Shoot := False)
{
    Shots := Shoot ? 40 : 0
    Jump(90, Shots)
}

HighJump(Shoot := False)
{
    Shots := Shoot ? 43 : 0
    Jump(165 , Shots)
}
