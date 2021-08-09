#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class BonusLevel
{
    _IsOpen := False
    IsOn := False
    static GreenColors := [0x00A100, 0x00A800]
    static RedColors := [0x0000AD, 0x0000B4]
    static PinkTopColor := 0xFF9BFA

    __New(SRC)
    {
        this.SRC := SRC

        this.StartButton := New PixelInfo(this.SRC.GetX(0.593), this.SRC.GetY(0.7848)) ; 770, 610
        this.SecondWindButton := New PixelInfo(this.SRC.GetX(0.3938), this.SRC.GetY(0.7709)) ; 515, 600
        this.CloseButton := New PixelInfo(this.SRC.GetX(0.6086), this.SRC.GetY(0.7709)) ; 790, 600
    }

    IsOpen[]
    {
        get
        {
            return (this.CanStart or this._IsOpen)
        }
    }

    CanStart[]
    {
        get
        {
            if (this.StartButton.CheckColors(BonusLevel.GreenColors))
            {
                this._IsOpen := True
                return True
            }
            return False
        }
    }

    CanClose[]
    {
        get
        {
            if (this.CloseButton.CheckColors(BonusLevel.RedColors))
                return True

            return False
        }
    }

    Complete()
    {
        if (this.CanStart and this.IsOn)
            this.StartButton.Click(200)
        if (this.CanClose and this.IsOn)
        {
            this.CloseButton.Click()
            this._IsOpen := False
            Return True
        }
        Return False
    }
}
