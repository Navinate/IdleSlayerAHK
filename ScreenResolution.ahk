#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force

Class ScreenResolutionController
{
    __New(X, Y, Width, Height)
    {
        this.Width := Width
        this.RealHeight := Floor(Width / X * Y)
        this.PadHeight := (Height - this.RealHeight)
    }

    GetX(Proportion)
    {
        Return Floor(this.Width * Proportion)
    }

    GetY(Proportion)
    {
        Return Floor(this.RealHeight * Proportion + this.PadHeight)
    }

}
