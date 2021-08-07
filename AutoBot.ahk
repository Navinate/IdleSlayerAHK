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

    AscensionToggle := False
    MinionsToggle := False
    PrestigeToggle := False
    LastItemToggle := False
    OldItemsToggle := False
    UpgradesToggle := False
    QuestsToggle := False

    JumpToggle := False
    BottomToggle := False
    BoostToggle := False

    BuyPeriod := 150
    BuyOldQMax := False

    RunningFunc := ""

    __New()
    {
        this.Game := New GameScreen()
        this.Minions := this.Minions.Bind(this)
        this.BuyAll := this.BuyAll.Bind(this)
        this.BuyLast := this.BuyLast.Bind(this)
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

            this.AscensionToggle := True
            this.MinionsToggle := True
            this.PrestigeToggle := True
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

        this.AscensionToggle := False
        this.MinionsToggle := False
        this.PrestigeToggle := False
        this.LastItemToggle := False
        this.OldItemsToggle := False
        this.UpgradesToggle := False
        this.QuestsToggle := False

        this.JumpToggle := False
        this.BottomToggle := False
        this.BoostToggle := False
    }

    Minions(IndexOp)
    {
        IsEnded := this.Game.AscensionMenu.Minions(IndexOp, this.PrestigeToggle)
        If (IsEnded)
        {
            this.Game.AscensionMenu.OpenAscensionTab()
            this.Game.AscensionMenu.CloseMenu()
        }
        Return IsEnded
    }

    BuyAll(IndexOp)
    {
        If (IndexOp == 0)
        {
            this.Game.EquipmentMenu.OpenEquipmentTab()
            If (this.Game.EquipmentMenu.IsOpen)
            {
                If (this.BuyOldQMax)
                    this.Game.EquipmentMenu.QMaxButton.Click()
                Else
                    this.Game.EquipmentMenu.Q50Button.Click()
            }
        }
        IsEnded := this.Game.EquipmentMenu.BuyAll(IndexOp)
        If (IsEnded)
        {
            if (this.QuestsToggle and this.Game.EquipmentMenu.CheckQuestUpdates())
                this.Game.EquipmentMenu.CompleteAllQuests()
            this.Game.EquipmentMenu.CloseMenu()
        }
        Return IsEnded
    }

    BuyLast(IndexOp)
    {
        If (IndexOp == 0)
        {
            this.Game.EquipmentMenu.OpenEquipmentTab()
            If (this.Game.EquipmentMenu.IsOpen)
                this.Game.EquipmentMenu.QMaxButton.Click()
        }
        IsEnded := this.Game.EquipmentMenu.BuyLast(IndexOp)
        If (IsEnded)
        {
            if (this.QuestsToggle and this.Game.EquipmentMenu.CheckQuestUpdates())
                this.Game.EquipmentMenu.CompleteAllQuests()
            this.Game.EquipmentMenu.CloseMenu()
        }
        Return IsEnded
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
            Mod50 := Mod(A_Index, 50)
            If (Mod50 == 0)
            {
                If (this.ChestHuntToggle and this.Game.ChestHunt.IsOpen)
                    this.Game.ChestHunt.Complete()
                If (this.BonusToggle)
                    this.Game.BonusLevel.Complete()
                If (this.RageToggle and this.Game.CheckRage())
                    this.Game.RageButton.Click()
                If (this.PortalToggle and this.Game.CheckPortal())
                {
                    this.Game.PortalButton.Click(500)
                    this.Game.Portal.BasicYesButton.Click()
                    Sleep 10000
                }
                If (this.SilverToggle and this.Game.CheckSilver())
                    this.Game.SilverButton.Click()
            }
            If (Mod(A_Index, 1000) == 0)
            {
                this.BuyPeriod := 900
                this.BuyOldQMax := False
            }
            If (this.AscensionToggle and (Mod(A_Index, 15000) == 14000))
            {
                this.Game.AscensionMenu.Ascend()
                Sleep 500
                this.Game.AscensionMenu.OpenAscensionTab()
                this.Game.AscensionMenu.CloseMenu()
                this.BuyPeriod := 150
                this.BuyOldQMax := True
                this.RunningFunc := ""
            }
            If (this.RunningFunc)
            {
                Var := this.RunningFunc
                If (!%Var%(Mod50))
                    Continue
                this.RunningFunc := ""
            }
            If (this.MinionsToggle and Mod50 == 49 and this.Game.AscensionMenu.IsUpdated)
                this.RunningFunc := this.Minions

            BuyMod := Mod(A_Index, this.BuyPeriod)
            If (this.OldItemsToggle and BuyMod == this.BuyPeriod - 1)
            {
                this.RunningFunc := this.BuyAll
            }
            If (this.LastItemToggle and (BuyMod == Floor(this.BuyPeriod / 3) - 1))
            {
                this.RunningFunc := this.BuyLast
            }
            If (this.UpgradesToggle and (BuyMod == Floor(this.BuyPeriod / 3 * 2) - 1))
            {
                this.Game.EquipmentMenu.UpgradeAll()
                if (this.QuestsToggle and this.Game.EquipmentMenu.CheckQuestUpdates())
                    this.Game.EquipmentMenu.CompleteAllQuests()
                this.Game.EquipmentMenu.CloseMenu()
            }

        }
    }
}