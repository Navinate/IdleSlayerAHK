#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk

Class AscensionMenu
{
    IsOpen[]
    {
        get {
            PixelGetColor, TempColor, 645, 400
            If TempColor == 0x3E8ABA
            {
                Return True
            }
            Return False
        }
    }

    OpenMenu()
    {
        If !this.IsOpen
        {
            ClickAt(80, 120)
        }
    }

    CloseMenu()
    {
        If this.IsOpen
        {
            ClickAt(520, 710)
        }
    }

    MainTab()
    {
        this.OpenMenu()
        ClickAt(90, 710)
    }

    AscensionTab()
    {
        this.OpenMenu()
        ClickAt(210, 710)
    }

    MinionsTab()
    {
        this.OpenMenu()
        ClickAt(325, 710)
    }

    DivinityTab()
    {
        this.OpenMenu()
        ClickAt(440, 710)
    }

    Ascend()
    {
        this.MainTab()
        ClickAt(90, 590)
    }
}

Menu := New AscensionMenu()

#IfWinActive Idle Slayer
    ~T:: 
        Menu.DivinityTab()
    Return
#IfWinActive