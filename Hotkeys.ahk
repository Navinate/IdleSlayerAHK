#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#MaxThreadsPerHotkey 3
#Include, AutoBot.ahk

Bot := New AutoBot()

#IfWinNotActive Idle Slayer
    ~LButton:: Toggle := False
#IfWinNotActive

#IfWinActive, Idle Slayer
    ~RButton:: Toggle := False

    T::
        if (!Bot)
        {
            MsgBox First need to initialize
            return
        }
        Bot.Toggle := !Bot.Toggle
        Bot.Join()
    Return

    C:: Bot.ClickToggle := !Bot.ClickToggle
    W:: Bot.ToggleAll()

    R:: Bot.RageToggle := !Bot.RageToggle
    ^R:: Bot.Game.RageButton.Click()
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
        Bot.Game.AscensionMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
    Return
    M:: Bot.MinionsToggle := !Bot.MinionsToggle
    ^M::
        ClickToggle := Bot.ClickToggle
        IsOn := Bot.Game.AscensionMenu.IsOn
        Bot.ClickToggle := False
        Bot.Game.AscensionMenu.IsOn := True
        Bot.Game.AscensionMenu.Minions()
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
        Bot.Game.EquipmentMenu.BuyAll()
        Bot.Game.EquipmentMenu.CloseMenu()
        Bot.ClickToggle := ClickToggle
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