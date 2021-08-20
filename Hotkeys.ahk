#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#MaxThreadsPerHotkey 3
#Include, AutoBot.ahk

Bot := New AutoBot()

#IfWinNotActive Idle Slayer
    ~LButton:: Bot.Toggle := False
#IfWinNotActive

#IfWinActive, Idle Slayer
    ~RButton:: Bot.Toggle := False

    F3::
        MouseGetPos, MouseX, MouseY
        PixelGetColor, Color, (MouseX), MouseY
        PixelGetColor, Color2, (MouseX + 50), MouseY
        MsgBox %MouseX% %MouseY% - %Color%, %Color2%
    Return

    T::
        if (!Bot)
        {
            MsgBox First need to initialize
            return
        }
        Bot.Toggle := !Bot.Toggle
        Bot.Join()
    Return

    E:: Bot.ClickToggle := True
    C:: Bot.ClickToggle := !Bot.ClickToggle
    W:: Bot.ToggleAll()

    R:: Bot.RageToggle := !Bot.RageToggle
    ^R:: Bot.Game.RageButton.Click()
    P:: Bot.PortalToggle := !Bot.PortalToggle
    B:: Bot.BonusToggle := !Bot.BonusToggle
    H:: Bot.ChestHuntToggle := !Bot.ChestHuntToggle
    ^H::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.ChestHunt.IsOn
        Bot.ClickToggle := False
        Bot.Game.ChestHunt.IsOn := True 
        Bot.Game.ChestHunt.ClickClosedChests()
        Bot.ClickToggle := ClickToggle
    Return
    S:: Bot.SilverToggle := !Bot.SilverToggle
    A:: Bot.AscensionToggle := !Bot.AscensionToggle
    ^A:: 
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.AscensionMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.AscensionMenu.IsOn := True
        Bot.Game.AscensionMenu.Ascend()
        Sleep 500
        Bot.Game.AscensionMenu.OpenAscensionTab()
        Bot.Game.AscensionMenu.CloseMenu()
        Bot.BuyPeriod := 100
        Bot.BuyOldQMax := True
        Bot.ClickToggle := ClickToggle
    Return
    M:: Bot.MinionsToggle := !Bot.MinionsToggle
    ^M::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.AscensionMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.AscensionMenu.IsOn := True
        Loop 13
            Bot.Game.AscensionMenu.Minions(A_Index - 1)
        Bot.Game.AscensionMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
    Return
    ,:: Bot.PrestigeToggle := !Bot.PrestigeToggle
    ^,:: 
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.AscensionMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.AscensionMenu.IsOn := True
        Loop 7
            Bot.Game.AscensionMenu.Minions(A_Index - 1, True)
        Bot.Game.AscensionMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
    Return
    L:: Bot.LastItemToggle := !Bot.LastItemToggle
    ^L::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.EquipmentMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.EquipmentMenu.IsOn := True
        Bot.Game.EquipmentMenu.OpenEquipmentTab()
        Bot.Game.EquipmentMenu.QMaxButton.Click()
        Loop 3
            Bot.Game.EquipmentMenu.BuyLast(A_Index - 1)
        Bot.Game.EquipmentMenu.BuyLast()
        Bot.Game.EquipmentMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
    Return
    O:: Bot.OldItemsToggle := !Bot.OldItemsToggle
    ^O::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.EquipmentMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.EquipmentMenu.IsOn := True
        Bot.Game.EquipmentMenu.OpenEquipmentTab()
        Bot.Game.EquipmentMenu.QMaxButton.Click()
        Loop 22
            Bot.Game.EquipmentMenu.BuyAll(A_Index - 1)
        Bot.Game.EquipmentMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
        Bot.Game.EquipmentMenu.IsOn := IsOn
    Return
    U:: Bot.UpgradesToggle := !Bot.UpgradesToggle
    ^U::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.EquipmentMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.EquipmentMenu.IsOn := True
        Bot.Game.EquipmentMenu.UpgradeAll()
        Bot.Game.EquipmentMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
    Return
    Q:: Bot.QuestsToggle := !Bot.QuestsToggle
    ^Q::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.EquipmentMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.EquipmentMenu.IsOn := True
        Bot.Game.EquipmentMenu.CompleteAllQuests()
        Bot.Game.EquipmentMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
    Return
    Z:: Bot.BoostToggle := !Bot.BoostToggle
    ^Z:: Bot.Game.Boost()

    J:: Bot.ToggleJump()
#IfWinActive