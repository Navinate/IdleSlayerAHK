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

    __New(Width, Height)
    {
        this.InitMenuButton(Width, Height)
        this.InitTabButtons(Width, Height)
        this.InitAscendButton(Width, Height)
        this.InitMinionButtons(Width, Height)
        this.CloseMenu()
    }

    InitMenuButton(Width, Height)
    {
        X := Floor(Width / 20)
        Y := Floor(Height / 10)
        this.MenuButton := SearchAndInit(X, Y, 2*X, 2*Y, 0xA44100, "AscensionMenu Button")
    }

    InitTabButtons(Width, Height)
    {
        X := Floor(Width * 0.07)
        Y := Floor(Height * 0.9)

        DeltaX := Floor(Width * 0.09)

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

    InitAscendButton(Width, Height)
    {
        X := Floor(Width * 0.12)
        Y := Floor(Height * 0.77)
        this.AscendButton := New PixelInfo(X, Y)

        X := Floor(Width * 0.43)
        this.AscendModalYesButton := New PixelInfo(X, Y)

        X := Floor(Width * 0.57)
        this.AscendModalNoButton := New PixelInfo(X, Y)
    }

    InitMinionButtons(Width, Height)
    {
        X := Floor(Width * 0.39)

        this.TopMinionButtons := [ New PixelInfo(X, Floor(Height * 0.43), False), New PixelInfo(X, Floor(Height * 0.62), False), New PixelInfo(X, Floor(Height * 0.81), False) ]

        this.BotMinionButtons := [ New PixelInfo(X, Floor(Height * 0.57), False), New PixelInfo(X, Floor(Height * 0.76), False) ]
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
        if (!this.IsOpen)
        {
            this.MenuButton.Click(Delay)
            this.IsOpen := True
        }
    }

    CloseMenu()
    {
        if this.IsOpen
        {
            this.CloseButton.Click()
            this.IsOpen := False
        }
    }

    OpenMainTab()
    {
        this.OpenMenu()
        this.MainTabButton.Click()
    }

    OpenAscensionTab()
    {
        this.OpenMenu()
        this.AscensionTabButton.Click()
    }

    OpenMinionsTab()
    {
        this.OpenMenu()
        this.MinionsTabButton.Click()
    }

    OpenDivinitiesTab()
    {
        this.OpenMenu()
        this.DivinitiesTabButton.Click()
    }

    Ascend()
    {
        this.OpenMainTab()
        this.AscendButton.Click(200)
        this.AscendModalYesButton.Click()

        this.IsOpen := False
    }

    Minions()
    {
        this.OpenMinionsTab()

        MouseMove this.AscendButton.X, this.AscendButton.Y, 0
        Loop 7 
            Send {WheelUp}
        Sleep 500

        For Index, Value in this.TopMinionButtons
        {
            Loop 2
                Value.Click()
        }

        Loop 7 
            Send {WheelDown}
        Sleep 500

        For Index, Value in this.BotMinionButtons
        {
            Loop 2
                Value.Click()
        }

        this.CloseMenu()
    }
}
