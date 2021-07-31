#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, ScreenResolution.ahk
#Include, Utils.ahk
#Include, PixelInfo.ahk
#Include, AscensionMenu.ahk

Class GameScreen
{
    ResolutionX := 1280
    ResolutionY := 720

    __New()
    {
        WinGetPos, , , Width, Height, Idle Slayer
        this.SRC := New ScreenResolutionController(this.ResolutionX, this.ResolutionY, Width, Height)

        this.InitBasicButtons()
        this.InitAscensionMenu()
        ; this.InitEquipmentMenu()
        ; this.InitMaterialsMenu()
        ; this.InitPortalMenu()
    }

    InitBasicButtons()
    {
        this.BoostButton := New PixelInfo(this.SRC.GetX(0.09), this.SRC.GetY(0.79), True)

        this.RageButton := New PixelInfo(this.SRC.GetX(0.85), this.SRC.GetY(0.13), True)

        this.SilverButton := New PixelInfo(this.SRC.GetX(0.49), this.SRC.GetY(0.02))
    }

    InitAscensionMenu()
    {
        this.AscensionMenu := New AscensionMenu(this.SRC)
    }

    CheckRage()
    {
        if (this.RageButton.CheckColor())
        {
            X1 := this.SRC.GetX(0.84)
            Y1 := this.SRC.GetY(0.17)
            X2 := this.SRC.GetX(0.86)
            Y2 := this.SRC.GetY(0.19)

            PixelSearch PX, PY, X1, Y1, X2, Y2, 0x02012E, 10, Fast
            if ErrorLevel
                Return True
        }
        return False
    }

    CheckBoost()
    {
        if (this.BoostButton.CheckColor())
        {
            X1 := this.SRC.GetX(0.08)
            Y1 := this.SRC.GetY(0.79)
            X2 := this.SRC.GetX(0.1)
            Y2 := this.SRC.GetY(0.81)

            PixelSearch PX, PY, X1, Y1, X2, Y2, 0x301604, 10, Fast
            if ErrorLevel
                Return True
        }
        return False
    }

}

#IfWinActive, Idle Slayer
    I::
        Game := New GameScreen()
        MsgBox Initialized
    Return

    M::
        Game.AscensionMenu._IsOn := True
        Game.AscensionMenu.Minions()
        Game.AscensionMenu.CloseMenu()
    Return

    R::
        Loop
        {
            If (Game.RageButton.CheckColor())
            {
                MsgBox Rage Button Ready!
                Break
            }
        }
    Return

#IfWinActive