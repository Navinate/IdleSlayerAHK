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
    static GreenColor := 0x00A100
    static RedColor := 0x0000AD

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

            if (this.StartButton.CheckColor(BonusLevel.GreenColor))
            {
                this._IsOpen := True
                return True
            }

            return this._IsOpen
        }
    }

    CanClose[]
    {
        get
        {
            if (this.CloseButton.CheckColor(BonusLevel.RedColor))
                return True

            return False
        }
    }

    Close()
    {
        if (this.CanClose and this.IsOn and this.IsOpen)
        {
            this.CloseButton.Click()
            this._IsOpen := False
        }
    }
}
