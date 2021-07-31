#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class ChestHunt
{
    _IsOn := True
    static Red := 0x0000AD

    __New(SRC)
    {
        this.SRC := SRC
        this.InitChests()
        this.InitButton()
    }

    InitButton()
    {
        this.CloseButton := New PixelInfo( this.SRC.GetX(0.38), this.SRC.GetY(0.9))
    }

    IsOpen[]
    {
        get
        {

        }
    }
}
