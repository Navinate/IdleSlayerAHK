#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class AscensionMenu
{
    IsOn := False

    static MenuButtonColors := [0xA44100, 0xAB4400]
    static TabButtonColors := [0x243388, 0x25358E]
    static CloseButtonColor := 0x1111AD
    static OnMissionColors := [0xC75B95, 0xCF5F9B]
    static CompleteMissionColors := [0x23AA11, 0x22A310]
    static StartMissionColors := [0x8B1856, 0x861753]
    static MaxColors := [0xFFFFFF, 0xD3D0D1]
    static OrangeColors := [0x0093FF, 0x008DF5]
    static GreenColor := 0x00A100

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

        this.ModalYesButton := New PixelInfo(this.SRC.GetX(0.4758), Y) ; 620

        this.ModalNoButton := New PixelInfo(this.SRC.GetX(0.6086), Y) ; 790
    }

    InitMinionButtons()
    {
        ; this.TopScrollButton := New PixelInfo(this.SRC.GetX(0.4719), this.SRC.GetY(0.3125), True, 0xD6D6D6) ; 615, 270
        this.BotScrollButton := New PixelInfo(this.SRC.GetX(0.4719), this.SRC.GetY(0.8403), True, 0xD6D6D6) ; 615, 650

        MissionButtonX := this.SRC.GetX(0.4368) ; 570
        MaxTextX := this.SRC.GetX(0.1102) ; 149
        PrestigeButtonX := this.SRC.getX(0.1735) ; 230

        DeltaY := this.SRC.getDY(0.2084) ; 150
        MissionButtonY := this.SRC.GetY(0.4667)
        MaxTextY := this.SRC.GetY(0.4473)
        this.TopMinions := []
        Loop 2
        {
            this.TopMinions.Push({ MissionButton: (New PixelInfo(MissionButtonX, MissionButtonY + DeltaY * (A_Index - 1))), MaxText: (New PixelInfo(MaxTextX, MaxTextY + DeltaY * (A_Index - 1))), PrestigeButton: (New PixelInfo(PrestigeButtonX, MaxTextY + DeltaY * (A_Index - 1))) }) ; 300, 450, 600
        }

        MissionButtonY := this.SRC.GetY(0.3055)
        MaxTextY := this.SRC.GetY(0.2764)
        this.BotMinions := []
        Loop 3
            this.BotMinions.Push({ MissionButton: New PixelInfo(MissionButtonX, MissionButtonY + DeltaY * (A_Index - 1)), MaxText: New PixelInfo(MaxTextX, MaxTextY + DeltaY * (A_Index - 1)), PrestigeButton: New PixelInfo(PrestigeButtonX, MaxTextY + DeltaY * (A_Index - 1)) }) ; 415, 565
    }

    IsOpen[]
    {
        get
        {
            if (this.MenuButton.CheckColors(AscensionMenu.MenuButtonColors))
                return False
            return this.CloseButton.CheckColor(AscensionMenu.CloseButtonColor)
        }
    }

    IsUpdated[]
    {
        get
        {
            if (this.MenuButton.CheckColors(AscensionMenu.MenuButtonColors) or this.IsOpen)
                return False
            return True
        }
    }

    OpenMenu(Delay := 150)
    {
        if (this.IsOn and !this.IsOpen)
            this.MenuButton.Click(Delay)
        return this.IsOpen
    }

    CloseMenu()
    {
        if (this.IsOn and this.IsOpen)
            this.CloseButton.Click()
        return !this.IsOpen
    }

    OpenMainTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.MainTabButton.Click()
        return True
    }

    OpenAscensionTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.AscensionTabButton.Click()
        return True
    }

    OpenMinionsTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.MinionsTabButton.Click()
        return True
    }

    OpenDivinitiesTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.DivinitiesTabButton.Click()
        return True
    }

    Ascend()
    {
        if (!this.IsOn or !this.OpenMainTab())
            return False

        this.AscendButton.Click(200)

        Success := False
        If (this.ModalYesButton.CheckColor(AscensionMenu.GreenColor))
            Success := True

        this.ModalYesButton.Click()

        return Success
    }

    RestartMission(MinionInfo, Prestige := False)
    {
        if (MinionInfo.MissionButton.CheckColors(AscensionMenu.CompleteMissionColors))
            MinionInfo.MissionButton.Click()
        if (Prestige and MinionInfo.MaxText.CheckColor(AscensionMenu.WhiteColor) and MinionInfo.PrestigeButton.CheckColors(AscensionMenu.OrangeColors))
        {
            MinionInfo.PrestigeButton.Click(200)
            this.ModalYesButton.Click(200)
        }
        if (MinionInfo.MissionButton.CheckColors(AscensionMenu.StartMissionColors))
            MinionInfo.MissionButton.Click()
    }

    Minions(IndexOp, AutoPrestige := False)
    {
        if (!this.IsOn)
            return True

        Switch IndexOp
        {
        case 0:
            if (!this.OpenMinionsTab())
                return True
        case 1:
            this.BotScrollButton.Click(200,100)
        case 2,3,4,6,7,8:
            this.RestartMission(this.BotMinions[Mod(IndexOp - 1, 4)], AutoPrestige)
        case 5,9:
            Loop 6 
                Send {WheelUp}
            Sleep 300
        case 10, 11:
            this.RestartMission(this.TopMinions[IndexOp-9], AutoPrestige)
        case 12:
            {
                Return True
            }
        Default:
            {
                Return False
            }
        }
        return False
    }
}
