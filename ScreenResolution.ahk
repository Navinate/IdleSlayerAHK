#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force

Class ScreenResolutionController
{
    __New(X, Y, Width, Height)
    {
        this.X := X
        this.Y := Y
        this.PadX := Floor(Round((Width - X) / 2))
        this.PadY := Floor(Round(Height - Y - this.PadX))
    }

    GetX(Proportion, NoPad := False)
    {
        Return Floor(Round(this.X * Proportion + (NoPad ? 0 : this.PadX), 10))
    }

    GetDX(Proportion)
    {
        Return this.GetX(Proportion, True)
    }

    GetY(Proportion, NoPad := False)
    {
        Return Floor(Round(this.Y * Proportion + (NoPad ? 0 : this.PadY), 10))
    }

    GetDY(Proportion)
    {
        Return this.GetY(Proportion, True)
    }
}
