#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force

#Include, GameScreen.ahk

Class AutoBot
{
    AllToggle := False

    RageToggle := False
    BonusToggle := False
    ChestHuntToggle := False
    SilverToggle := False
    PortalToggle := False

    AscentionToggle := False
    MinionsToggle := False
    LastItemToggle := False
    OldItemsToggle := False
    UpgradesToggle := False
    QuestsToggle := False

    JumpToggle := False
    BottomToggle := False
    BoostToggle := False

    BuyPeriod := 900
    BuyOldQMax := False

    __New()
    {
        this.Game := New GameScreen()
    }

    Toggle[]
    {
        get
        {
            return this.Game.IsOn
        }
        set
        {
            return this.Game.IsOn := value
        }
    }

    ClickToggle[]
    {
        get
        {
            return this.Game.IsMouseOn
        }
        set
        {
            return this.Game.IsMouseOn := value
        }
    }

    ToggleJump()
    {
        If (!this.JumpToggle and !this.BottomToggle)
        {
            this.JumpToggle := True
            Return
        }
        If (this.JumpToggle)
        {
            this.JumpToggle := False
            this.BottomToggle := True
            Return
        }
        If (this.BottomToggle)
        {
            this.BottomToggle := False
            Return
        }
    }

    ToggleAll()
    {
        this.AllToggle := !this.AllToggle
        If (this.AllToggle)
        {
            this.RageToggle := True
            this.SilverToggle := True
            ; this.PortalToggle := True
            this.BonusToggle := True
            this.ChestHuntToggle := True

            this.AscentionToggle := True
            this.MinionsToggle := True
            this.LastItemToggle := True
            this.OldItemsToggle := True
            this.UpgradesToggle := True
            this.QuestsToggle := True

            this.JumpToggle := True
            this.BottomToggle := False
            this.BoostToggle := True
            Return
        }
        this.RageToggle := False
        this.SilverToggle := False
        this.PortalToggle := False
        this.BonusToggle := False
        this.ChestHuntToggle := False

        this.AscentionToggle := False
        this.MinionsToggle := False
        this.LastItemToggle := False
        this.OldItemsToggle := False
        this.UpgradesToggle := False
        this.QuestsToggle := False

        this.JumpToggle := False
        this.BottomToggle := False
        this.BoostToggle := False
    }

    Join()
    {
        Loop
        {

            If (!this.Game.IsOn)
                Return

            If (this.JumpToggle)
                this.Game.Jump(Mod(A_Index, 10) * 20 + 5, 0)
            Else 
            {
                If (this.BottomToggle and !(Mod(A_Index, 20)))
                    this.Game.Jump(100, 0)
                Else 
                    Sleep, 100
            }

            If (this.BoostToggle)
                this.Game.Boost()

            If (!this.ClickToggle)
                Continue

            If (Mod(A_Index, 50) == 0)
            {
                If (this.ChestHuntToggle and this.Game.ChestHunt.IsOpen)
                    this.Game.ChestHunt.Complete()

                If (this.RageToggle and this.Game.CheckRage())
                    this.Game.RageButton.Click()

                If (this.PortalToggle and this.Game.CheckPortal())
                    {
                        this.Game.PortalButton.Click(500)
                        this.Game.Portal.BasicYesButton.Click()
                        Sleep 10000
                    }

                this.Game.BonusLevel.Close()
                If (this.SilverToggle and this.Game.CheckSilver())
                    this.Game.SilverButton.Click()

                If (this.MinionsToggle and this.Game.AscensionMenu.IsUpdated)
                {
                    this.Game.AscensionMenu.Minions()
                    If (this.Game.AscensionMenu.IsUpdated)
                        this.Game.AscensionMenu.OpenAscensionTab()
                    this.Game.AscensionMenu.CloseMenu()
                }
            }
            If (this.OldItemsToggle and (Mod(A_Index, this.BuyPeriod) == 0))
            {
                this.Game.EquipmentMenu.OpenEquipmentTab()
                If (this.Game.EquipmentMenu.IsOpen)
                {
                    If (this.BuyOldQMax)
                        this.Game.EquipmentMenu.QMaxButton.Click()
                    Else
                        this.Game.EquipmentMenu.Q50Button.Click()
                }
                this.Game.EquipmentMenu.BuyAll()
                if (this.QuestsToggle and this.Game.EquipmentMenu.CheckQuestUpdates())
                    this.Game.EquipmentMenu.CompleteAllQuests()
                this.Game.EquipmentMenu.CloseMenu()
            }
            If (this.LastItemToggle and (Mod(A_Index, this.BuyPeriod) == Floor(this.BuyPeriod / 3)))
            {
                this.Game.EquipmentMenu.OpenEquipmentTab()
                If (this.Game.EquipmentMenu.IsOpen)
                    this.Game.EquipmentMenu.QMaxButton.Click()
                this.Game.EquipmentMenu.BuyLast()
                if (this.QuestsToggle and this.Game.EquipmentMenu.CheckQuestUpdates())
                    this.Game.EquipmentMenu.CompleteAllQuests()
                this.Game.EquipmentMenu.CloseMenu()
            }
            If (this.UpgradesToggle and (Mod(A_Index, this.BuyPeriod) == Floor(this.BuyPeriod / 3 * 2)))
            {
                this.Game.EquipmentMenu.UpgradeAll()
                if (this.QuestsToggle and this.Game.EquipmentMenu.CheckQuestUpdates())
                    this.Game.EquipmentMenu.CompleteAllQuests()
                this.Game.EquipmentMenu.CloseMenu()
            }

            If (Mod(A_Index, 1000) == 0)
            {
                this.BuyPeriod := 900
                this.BuyOldQMax := False
            }
            If (this.AscentionToggle and (Mod(A_Index, 15000) == 14000))
            {
                this.Game.AscensionMenu.Ascend()
                Sleep 500
                this.Game.AscensionMenu.OpenAscensionTab()
                this.Game.AscensionMenu.CloseMenu()
                this.BuyPeriod := 100
                this.BuyOldQMax := True
            }

        }
    }
}