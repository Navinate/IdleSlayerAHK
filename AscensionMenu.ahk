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
    IsOn := False

    static MenuButtonColors := [0xA44100, 0xAB4400]
    static TabButtonColors := [0x243388, 0x25358E]
    static CloseButtonColor := 0x1111AD
    ; static OnMissionColor := 0xCF5F9B
    ; static CompleteMissionColor := 0x23AA11
    ; static StartMissionColor := 0x8B1856

    __New(SRC)
    {
        this.SRC := SRC
        this.InitMenuButton()
        this.InitTabButtons()
        this.InitAscendButton()
        this.InitMinionButtons()
    }

    InitMenuButton()
    {
        this.MenuButton := New PixelInfo(this.SRC.GetX(0.0555), this.SRC.GetY(0.1167)) ; 82, 129
    }

    InitTabButtons()
    {
        X := this.SRC.GetX(0.0969) ; 135
        Y := this.SRC.GetY(0.9098) ; 700
        DeltaX := this.SRC.GetDX(0.0938) ; 120

        this.MainTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.AscensionTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.MinionsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.DivinitiesTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.CloseButton := New PixelInfo(X, Y)
    }

    InitAscendButton()
    {
        Y := this.SRC.GetY(0.7778) ; 605
        this.AscendButton := New PixelInfo(this.SRC.GetX(0.0891), Y) ; 125

        this.AscendModalYesButton := New PixelInfo(this.SRC.GetX(0.4368), Y) ; 570

        this.AscendModalNoButton := New PixelInfo(this.SRC.GetX(0.5696), Y) ; 740
    }

    InitMinionButtons()
    {
        this.TopScrollButton := New PixelInfo(this.SRC.GetX(0.4719), this.SRC.GetY(0.3125), True, 0xD6D6D6) ; 615, 270
        this.BotScrollButton := New PixelInfo(this.SRC.GetX(0.4719), this.SRC.GetY(0.8403), True, 0xD6D6D6) ; 615, 650

        X := this.SRC.GetX(0.4368) ; 570

        this.TopMinionButtons := [ New PixelInfo(X, this.SRC.GetY(0.3542)), New PixelInfo(X, this.SRC.GetY(0.5625)), New PixelInfo(X, this.SRC.GetY(0.7709)) ] ; 300, 450, 600

        this.BotMinionButtons := [ New PixelInfo(X, this.SRC.GetY(0.5139)), New PixelInfo(X, this.SRC.GetY(0.7223)) ] ; 415, 565
    }

    IsOpen[]
    {
        get
        {
            if (this.MenuButton.CheckColors(AscensionMenu.MenuButtonColors))
            {
                this._IsOpen := False
                return False
            }
            if (!this.CloseButton.CheckColor(AscensionMenu.CloseButtonColor))
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
        if (!this.IsOpen and this.IsOn)
        {
            this.MenuButton.Click(Delay)
            this.IsOpen := True
        }
    }

    CloseMenu()
    {
        if (this.IsOpen and this.IsOn)
        {
            this.CloseButton.Click()
            this.IsOpen := False
        }
    }

    OpenMainTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.MainTabButton.Click()
    }

    OpenAscensionTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.AscensionTabButton.Click()
    }

    OpenMinionsTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.MinionsTabButton.Click()
    }

    OpenDivinitiesTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.DivinitiesTabButton.Click()
    }

    Ascend()
    {
        if (!this.IsOn)
            return

        this.OpenMainTab()
        this.AscendButton.Click(200)
        this.AscendModalYesButton.Click()

        this.IsOpen := False
    }

    Minions()
    {
        if (!this.IsOn)
            return

        this.OpenMinionsTab()

        this.TopScrollButton.Click()

        For Index, Value in this.TopMinionButtons
        {
            if (!this.IsOn)
                return

            Loop 2
                Value.Click()
        }

        this.BotScrollButton.Click()

        For Index, Value in this.BotMinionButtons
        {
            if (!this.IsOn)
                return

            Loop 2
                Value.Click()
        }
    }
}
