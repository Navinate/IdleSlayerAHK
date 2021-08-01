#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk
#Include, ScreenResolution.ahk
#Include, AscensionMenu.ahk
#Include, EquipmentMenu.ahk
#Include, ChestHunt.ahk
#Include, BonusLevel.ahk

Class GameScreen
{
    ResolutionX := 1280
    ResolutionY := 720
    _IsOn := False
    _IsMouseOn := True

    static BoostColors := [0x943F06, 0x9A4106]
    static BoostActiveColors := [0x301604, 0x321704]
    static RageColors := [0x060393, 0x060399]
    static RageActiveColors := [0x020130, 0x02012E]
    static SilverColors := [0x00A2D8]

    __New()
    {
        WinGetPos, , , Width, Height, Idle Slayer
        this.SRC := New ScreenResolutionController(this.ResolutionX, this.ResolutionY, Width, Height)

        this.InitBasicButtons()
        this.AscensionMenu := New AscensionMenu(this.SRC)
        this.EquipmentMenu := New EquipmentMenu(this.SRC)
        this.ChestHunt := New ChestHunt(this.SRC)
        this.BonusLevel := New BonusLevel(this.SRC)
        ; this.InitMaterialsMenu()
        ; this.InitPortalMenu()
    }

    InitBasicButtons()
    {
        this.BoostButton := New PixelInfo(this.SRC.GetX(0.0883), this.SRC.GetY(0.8042)) ; 124, 624
        this.RageButton := New PixelInfo(this.SRC.GetX(0.8547), this.SRC.GetY(0.1223)) ; 1105, 133
        this.SilverButton := New PixelInfo(this.SRC.GetX(0.5204), this.SRC.GetY(0.025)) ; 677, 63
    }

    CheckToggle()
    {
        if (this._IsOn and this._IsMouseOn)
        {
            this.AscensionMenu.IsOn := True
            this.EquipmentMenu.IsOn := True
            this.ChestHunt.IsOn := True
            this.BonusLevel.IsOn := True
            return
        }
        this.AscensionMenu.IsOn := False
        this.EquipmentMenu.IsOn := False
        this.ChestHunt.IsOn := False
        this.BonusLevel.IsOn := False
        return
    }

    IsOn[]
    {
        get
        {
            return this._IsOn
        }
        set
        {
            this._IsOn := value
            this.CheckToggle()
            return value
        }
    }

    IsMouseOn[]
    {
        get
        {
            return this._IsMouseOn
        }
        set
        {
            this._IsMouseOn := value
            this.CheckToggle()
            return value
        }
    }

    CheckRage()
    {
        if (this.RageButton.CheckColors(GameScreen.RageColors))
            return !!(this.RageButton.SearchColorsAround(GameScreen.RageActiveColors, 10, 10))
        return False
    }

    CheckBoost()
    {
        if (this.BoostButton.CheckColors(GameScreen.BoostColors))
            return !!(this.BoostButton.SearchColorsAround(GameScreen.BoostActiveColors, 10, 10))
        return False
    }

    CheckSilver()
    {
        return !!(this.SilverButton.CheckColors(GameScreen.SilverColors))
    }

    Boost()
    {
        PressShift()
    }

    ShootBow()
    {
        PressSpace(1)
    }

    Jump(Delay := 20, Shots := 10)
    {
        PressSpace(Delay)

        Loop %Shots%
            this.ShootBow()
    }

    LowJump(Shoot := False)
    {
        Shots := Shoot ? 30 : 0
        this.Jump(20, Shots)
    }

    MediumJump(Shoot := False)
    {
        Shots := Shoot ? 33 : 0
        this.Jump(90, Shots)
    }

    HighJump(Shoot := False)
    {
        Shots := Shoot ? 36 : 0
        this.Jump(165 , Shots)
    }
}