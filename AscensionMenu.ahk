#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class AscensionMenu
{
    _IsOpen := False
    _IsOn := True

    __New(SRC)
    {
        this.SRC := SRC
        this.InitMenuButton()
        this.InitTabButtons()
        this.InitAscendButton()
        this.InitMinionButtons()
        this.CloseMenu()
        this._IsOn := False
    }

    InitMenuButton()
    {
        this.MenuButton := SearchAndInit(this.SRC.GetX(0.05), this.SRC.GetY(0.05), this.SRC.GetX(0.1), this.SRC.GetY(0.15), 0xA44100, "AscensionMenu Button")
    }

    InitTabButtons()
    {
        this.OpenMenu()
        X := this.SRC.GetX(0.07)
        Y := this.SRC.GetY(0.89)
        DeltaX := this.SRC.GetX(0.09)

        this.MainTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.AscensionTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.MinionsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.DivinitiesTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.CloseButton := New PixelInfo(X, Y, True)
    }

    InitAscendButton()
    {
        Y := this.SRC.GetY(0.77)
        this.AscendButton := New PixelInfo(this.SRC.GetX(0.12), Y)

        this.AscendModalYesButton := New PixelInfo(this.SRC.GetX(0.43), Y)

        this.AscendModalNoButton := New PixelInfo(this.SRC.GetX(0.57), Y)
    }

    InitMinionButtons()
    {
        X := this.SRC.GetX(0.39)

        this.TopMinionButtons := [ New PixelInfo(X, this.SRC.GetY(0.43)), New PixelInfo(X, this.SRC.GetY(0.62)), New PixelInfo(X, this.SRC.GetY(0.81)) ]

        this.BotMinionButtons := [ New PixelInfo(X, this.SRC.GetY(0.57)), New PixelInfo(X, this.SRC.GetY(0.76)) ]
    }

    Toggle()
    {
        this._IsOn := !this._IsOn
    }

    IsOpen[]
    {
        get
        {
            if (this.MenuButton.CheckColor())
            {
                this._IsOpen := False
                return False
            }
            if (!this.CloseButton.CheckColor())
            {
                this._IsOpen := False
                return False
            }
            return this._IsOpen
        }
        set
        {
            return this._IsOpen := value
        }
    }

    IsUpdated[]
    {
        get
        {
            if (this.MenuButton.CheckColor() or this.IsOpen)
                return False
            return True
        }
    }

    OpenMenu(Delay := 150)
    {
        if (!this.IsOpen and this._IsOn)
        {
            this.MenuButton.Click(Delay)
            this.IsOpen := True
        }
    }

    CloseMenu()
    {
        if (this.IsOpen and this._IsOn)
        {
            this.CloseButton.Click()
            this.IsOpen := False
        }
    }

    OpenMainTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.MainTabButton.Click()
    }

    OpenAscensionTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.AscensionTabButton.Click()
    }

    OpenMinionsTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.MinionsTabButton.Click()
    }

    OpenDivinitiesTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.DivinitiesTabButton.Click()
    }

    Ascend()
    {
        if (!this._IsOn)
            return

        this.OpenMainTab()
        this.AscendButton.Click(200)
        this.AscendModalYesButton.Click()

        this.IsOpen := False
    }

    Minions()
    {
        if (!this._IsOn)
            return

        this.OpenMinionsTab()

        MouseMove this.AscendButton.X, this.AscendButton.Y, 0
        Loop 7 
            Send {WheelUp}
        Sleep 500

        For Index, Value in this.TopMinionButtons
        {
            if (!this._IsOn)
                return

            Loop 2
                Value.Click()
        }

        Loop 7 
            Send {WheelDown}
        Sleep 500

        For Index, Value in this.BotMinionButtons
        {
            if (!this._IsOn)
                return

            Loop 2
                Value.Click()
        }
    }
}
