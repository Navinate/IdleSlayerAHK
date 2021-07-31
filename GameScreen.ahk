#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
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

        RealHeight := Floor(Width / this.ResolutionX * this.ResolutionY)
        PadHeight := Height - RealHeight

        this.InitBasicButtons(Width, Height)
        this.InitAscensionMenu(Width, Height)
        ; this.InitEquipmentMenu()
        ; this.InitMaterialsMenu()
        ; this.InitPortalMenu()
    }

    InitBasicButtons(Width, Height)
    {
        X := Floor(Width * 0.09)
        Y := Floor(Height * 0.8)
        this.BoostButton := New PixelInfo(X, Y, True)

        X := Floor(Width * 0.85)
        Y := Floor(Height * 0.18)
        this.RageButton := New PixelInfo(X, Y, True)

        X := Floor(Width * 0.49)
        Y := Floor(Height * 0.08)
        this.SilverButton := New PixelInfo(X, Y)
    }

    InitAscensionMenu(Width, Height)
    {
        this.AscensionMenu := New AscensionMenu(Width, Height)
    }

    CheckRage()
    {
        if (this.RageButton.CheckColor())
        {
            X1 := Floor(Width * 0.84)
            Y1 := Floor(Height * 0.17)
            X2 := Floor(Width * 0.86)
            Y2 := Floor(Height * 0.19)

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
            X1 := Floor(Width * 0.08)
            Y1 := Floor(Height * 0.79)
            X2 := Floor(Width * 0.1)
            Y2 := Floor(Height * 0.81)

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