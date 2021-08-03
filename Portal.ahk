#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class Portal
{
    _IsOpen := False
    IsOn := False

    __New(SRC)
    {
        this.SRC := SRC

        this.BasicYesButton := New PixelInfo(this.SRC.GetX(0.4625), this.SRC.GetY(0.7903)) ; 600, 600
    }

    ; IsOpen[]
    ; {
    ;     get
    ;     {
    ;         if (this.CloseButton.CheckColors(ChestHunt.StartBackgroundColors))
    ;         {
    ;             this._IsOpen := True
    ;             return True
    ;         }
    ;         return this._IsOpen
    ;     }
    ; }
}
