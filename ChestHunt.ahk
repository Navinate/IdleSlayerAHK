#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class ChestHunt
{
    _IsOpen := False
    IsOn := False
    static RedColors := [0x0000AD, 0x0000B4]
    static ChestKeyHoleColors := [0x31BBFF, 0x2FB4F5]

    __New(SRC)
    {
        this.SRC := SRC

        this.Chests := []
        StartX := this.SRC.GetX(0.1649) ; 222
        DeltaX := this.SRC.GetDX(0.0743) ; 95
        Y := this.SRC.GetY(0.3848) ; 322
        DeltaY := this.SRC.GetDY(0.1389) ; 100
        Loop 3
        {
            X := StartX
            Loop 10
            {
                this.Chests.Push(New PixelInfo(X, Y))
                X := X + DeltaX
            }
            Y := Y + DeltaY
        }

        this.CloseButton := New PixelInfo(this.SRC.GetX(0.3782), this.SRC.GetY(0.9098)) ; 495, 700
    }

    IsOpen[]
    {
        get
        {
            if (!this._IsOpen)
            {
                For Index, Value in this.Chests
                {
                    if (!Value.CheckColors(ChestHunt.ChestKeyHoleColors))
                        return False
                }
                this._IsOpen := True
            }
            return this._IsOpen
        }
    }

    CanClose[]
    {
        get
        {
            if (this.CloseButton.CheckColors(ChestHunt.RedColors))
                return True

            return False
        }
    }

    ClickClosedChests()
    { 
        For Index, ChestInfo in this.Chests
        {
            if (!this.IsOn)
            {
                this._IsOpen := False
                Break
            }
            if (ChestInfo.CheckColors(ChestHunt.ChestKeyHoleColors))
                ChestInfo.Click(200)
        }
    }

    Close()
    {
        if (this.CanClose and this.IsOn)
        {
            this.CloseButton.Click()
            this._IsOpen := False
        }
    }

    Complete()
    {
        Loop
        {
            if (!this.IsOn or !this.IsOpen)
                Return

            this.ClickClosedChests()
            this.Close()
        }
    }
}
