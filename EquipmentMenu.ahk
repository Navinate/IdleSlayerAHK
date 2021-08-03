#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#Include, Utils.ahk
#Include, PixelInfo.ahk

Class EquipmentMenu
{
    _IsOpen := False
    IsOn := False

    static MenuButtonColors := [0x929292, 0x989898]
    static TabButtonColors := [0x243388, 0x243488, 0x25368E]
    static CloseButtonColor := 0x1010A6
    static GreenColors := [0x23AA11, 0x22A310]

    __New(SRC)
    {
        this.SRC := SRC
        this.InitMenuButton()
        this.InitTabButtons()
        this.InitInnerButtons()
    }

    InitMenuButton()
    {
        this.MenuButton := New PixelInfo(this.SRC.GetX(0.8821), this.SRC.GetY(0.8195)) ; 1140, 635
    }

    InitTabButtons()
    {
        X := this.SRC.GetX(0.6868) ; 890
        Y := this.SRC.GetY(0.875) ; 675
        DeltaX := this.SRC.GetDX(0.0579) ; 74

        this.EquipmentTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.UpdatesTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.QuestsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.JewelsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.StatsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.CloseButton := New PixelInfo(X, Y)
    }

    InitInnerButtons()
    {
        this.TopScrollBuyButton := New PixelInfo(this.SRC.GetX(0.9735), this.SRC.GetY(0.207)) ; 1257, 194
        this.BotScrollBuyButton := New PixelInfo(this.SRC.GetX(0.9735), this.SRC.GetY(0.7764)) ; 1257, 604

        this.TopScrollQuestButton := New PixelInfo(this.SRC.GetX(0.9735), this.SRC.GetY(0.3375)) ; 1257, 288
        this.BotScrollQuestButton := New PixelInfo(this.SRC.GetX(0.9735), this.SRC.GetY(0.8417)) ; 1257, 651

        Y := this.SRC.GetY(0.8264) ; 640
        this.Q1Button := New PixelInfo(this.SRC.GetX(0.7649), Y) ; 990
        this.Q10Button := New PixelInfo(this.SRC.GetX(0.8157), Y) ; 1055
        this.Q50Button := New PixelInfo(this.SRC.GetX(0.8665), Y) ; 1120
        this.QMaxButton := New PixelInfo(this.SRC.GetX(0.9172), Y) ; 1185

        X := this.SRC.GetX(0.9563) ; 1235
        this.TopBuyButtons := []
        StartY := this.SRC.GetY(0.2431) ; 220
        DeltaY := this.SRC.GetDY(0.1389) ; 100
        Loop 4
            this.TopBuyButtons.Push(New PixelInfo(X, StartY + DeltaY * (A_Index - 1)))

        this.BotBuyButtons := []

        StartY := this.SRC.GetY(0.7153) ; 560
        Loop 4
            this.BotBuyButtons.Push(New PixelInfo(X, StartY - DeltaY * (A_Index - 1)))

        this.UpdateAllButton := this.Q10Button

        this.QuestButtons := []
        StartY := this.SRC.GetY(0.3542) ; 300
        DeltaY := this.SRC.GetDY(0.0459) ; 33
        Loop 10
            this.QuestButtons.Push(New PixelInfo(X, StartY + DeltaY * (A_Index - 1)))
    }

    IsOpen[]
    {
        get
        {
            if (this.MenuButton.CheckColors(EquipmentMenu.MenuButtonColors))
            {
                this._IsOpen := False
                return False
            }
            if (!this.CloseButton.CheckColor(EquipmentMenu.CloseButtonColor))
            {
                this._IsOpen := False
                return False
            }
            return this._IsOpen
        }
        set
        {
            return this._IsOpen := value
        }
    }

    IsUpdated[]
    {
        get
        {
            if (this.MenuButton.CheckColors(EquipmentMenu.MenuButtonColors) or this.IsOpen)
                return False
            return True
        }
    }

    OpenMenu(Delay := 150)
    {
        if (!this.IsOn or this.IsOpen)
            return

        this.MenuButton.Click(Delay)
        this.IsOpen := True
    }

    CloseMenu()
    {
        if (!this.IsOn)
            return

        this.CloseButton.Click()
        this.IsOpen := False
    }

    OpenEquipmentTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.EquipmentTabButton.Click()
    }

    OpenUpdatesTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.UpdatesTabButton.Click()
    }

    OpenQuestsTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.QuestsTabButton.Click()
    }

    OpenJewelsTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.JewelsTabButton.Click()
    }

    OpenStatsTab()
    {
        if (!this.IsOn)
            return

        this.OpenMenu()
        this.StatsTabButton.Click()
    }

    BuyAll()
    {
        if (!this.IsOn)
            return

        this.OpenEquipmentTab()
        this.BotScrollBuyButton.Click(100,100)

        Loop 3
        {
            For Index, Value in this.BotBuyButtons
            {
                if (!this.IsOn)
                    return
                Value.Click()
            }

            Loop 8 
                Send {WheelUp}
            Sleep 300
        }
        For Index, Value in this.TopBuyButtons
        {
            if (!this.IsOn)
                return
            Value.Click()
        }
    }

    BuyLast()
    {
        if (!this.IsOn)
            return

        this.OpenEquipmentTab()

        this.BotScrollBuyButton.Click(100,100)
        this.BotBuyButtons[1].Click()
    }

    UpgradeAll()
    {
        if (!this.IsOn)
            return

        this.OpenUpdatesTab()

        Loop 3
            this.UpdateAllButton.Click()
    }

    CompleteAllQuests()
    {
        if (!this.IsOn)
            return

        this.OpenQuestsTab()
        this.TopScrollQuestButton.Click(100,100)

        Loop 5
        {
            For Index, QButton in this.QuestButtons
            {
                if (!this.IsOn)
                    return
                if (QButton.CheckColors(EquipmentMenu.GreenColors))
                    QButton.Click()
            }
            Loop 8 
                Send {WheelDown}
            Sleep 300
        }
    }

    CheckQuestUpdates()
    {
        if (!this.IsOn or (!this.IsOpen and !this.IsUpdated))
            return False

        this.OpenMenu()
        If (this.QuestsTabButton.CheckColors(EquipmentMenu.TabButtonColors))
            return False
        return True
    }
}
