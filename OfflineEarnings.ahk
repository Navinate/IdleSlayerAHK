#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#MaxThreadsPerHotkey 3
#Include, Utils.ahk
#Include, PixelInfo.ahk
#Include, GameScreen.ahk


CloseTheGame()
{
    global Game
    Loop
    {
        Send {Esc Down}
        Sleep 20
        Send {Esc Up}
        Sleep 200

        If (Game.ExitYesModalButton.CheckColors(Game.AscensionMenu.GreenColors))
        {
            Game.ExitYesModalButton.Click()
            Break
        }
        Sleep 1000
    }
}

Game := New GameScreen()
DE := New PixelInfo(Game.SRC.GetX(0.53), Game.SRC.GetY(0.0209))
CloseTheGame()

T::
    Game.IsOn := !Game.IsOn
    Loop
    {
        if (!Game.IsOn)
            Return
        Send {Space}
        Send {Enter}
        Sleep, 10000

        WinActivate, Idle Slayer
        DE.Click(10000)
        Game.RageButton.Click()

        Loop 13
            Game.AscensionMenu.Minions(A_Index - 1)
        Game.AscensionMenu.CloseMenu()

        Sleep 10000

        DE.Click()
        DE.Click()

        CloseTheGame()
        Sleep 600000
    }
Return