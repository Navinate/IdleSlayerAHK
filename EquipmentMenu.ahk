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
    static ScrollBarColors := [0xF5F5F5, 0xD6D6D6, 0xFFFFFF]
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
        this.MenuButton := New PixelInfo(this.SRC.GetX(0.8805), this.SRC.GetY(0.9112)) ; 1135, 687
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
        DeltaY := this.SRC.GetDY(0.1389) ; 100

        this.BotBuyButtons := []
        StartY := this.SRC.GetY(0.7237) ; 566
        Loop 4
            this.BotBuyButtons.Push(New PixelInfo(X, StartY - DeltaY * (A_Index - 1)))

        this.TopBuyButtons := []
        StartY := this.SRC.GetY(0.2431) ; 220
        Loop 4
            this.TopBuyButtons.Push(New PixelInfo(X, StartY + DeltaY * (A_Index - 1)))

        X := this.SRC.GetX(0.9688) ; 1246
        this.BuyButtonsNoBar := []
        Loop 4
            this.BuyButtonsNoBar.Push(New PixelInfo(X, StartY + DeltaY * (A_Index - 1)))

        this.UpdateAllButton := this.Q10Button

        this.QuestButtonsBar := []
        X := this.SRC.GetX(0.9563) ; 1235
        StartY := this.SRC.GetY(0.3542) ; 300
        DeltaY := this.SRC.GetDY(0.0459) ; 33
        Loop 10
            this.QuestButtonsBar.Push(New PixelInfo(X, StartY + DeltaY * (A_Index - 1)))

        this.QuestButtonsNoBar := []
        X := this.SRC.GetX(0.9688) ; 1246
        Loop 10
            this.QuestButtonsNoBar.Push(New PixelInfo(X, StartY + DeltaY * (A_Index - 1)))
    }

    IsOpen[]
    {
        get
        {
            if (this.MenuButton.CheckColors(EquipmentMenu.MenuButtonColors))
                return this._IsOpen := False

            if (!this.CloseButton.CheckColor(EquipmentMenu.CloseButtonColor))
                return this._IsOpen := False

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
        if (this.IsOn and !this.IsOpen)
        {
            this.MenuButton.Click(Delay)
            this.IsOpen := True
        }
        return this.IsOpen
    }

    CloseMenu()
    {
        if (this.IsOn and this.IsOpen)
        {
            this.CloseButton.Click()
            this.IsOpen := False
        }
        return !this.IsOpen
    }

    OpenEquipmentTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.EquipmentTabButton.Click()
        return True
    }

    OpenUpdatesTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.UpdatesTabButton.Click()
        return True
    }

    OpenQuestsTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.QuestsTabButton.Click()
        return True
    }

    OpenJewelsTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.JewelsTabButton.Click()
        return True
    }

    OpenStatsTab()
    {
        if (!this.IsOn or !this.OpenMenu())
            return False

        this.StatsTabButton.Click()
        return True
    }

    BuyAll(IndexOp)
    {
        if (!this.IsOn)
            return True

        NoBar := !this.BotScrollBuyButton.CheckColors(EquipmentMenu.ScrollBarColors)
        TBB := NoBar ? this.BuyButtonsNoBar : this.TopBuyButtons

        Switch IndexOp
        {
        case 0:
            if (!this.OpenEquipmentTab())
                return True
        case 1:
            this.BotScrollBuyButton.Click(200,100)

        case 2, 3, 4, 5, 7, 8, 9, 10, 12, 13, 14, 15:
            Ind := Mod(IndexOp - 1, 5)
            if (this.BotBuyButtons[Ind].CheckColors(EquipmentMenu.GreenColors))
                this.BotBuyButtons[Ind].Click()

        case 6, 11, 16:
            Loop 8 
                Send {WheelUp}
            Sleep 300

        case 17, 18, 19, 20:
            Ind := IndexOp - 16
            if (TBB[Ind].CheckColors(EquipmentMenu.GreenColors))
                TBB[Ind].Click()

        case 21:
            {
                return True
            }
        Default:
            {
                Return False
            }
        }
        return False
    }

    BuyLast(IndexOp)
    {
        if (!this.IsOn)
        return True

    Switch IndexOp
    {
    Case 0:
        If (!this.OpenEquipmentTab())
            Return True
    Case 1:
        if (!this.BotScrollBuyButton.CheckColors(EquipmentMenu.ScrollBarColors))
        {
            Loop 4
            {
                if (this.BuyButtonsNoBar[5 - A_Index].CheckColors(EquipmentMenu.GreenColors))
                {
                    this.BuyButtonsNoBar[5 - A_Index].Click()
                    return True
                }
            }
        }
        this.BotScrollBuyButton.Click(200,100)
    Case 2:
        {
            if (this.BotBuyButtons[1].CheckColors(EquipmentMenu.GreenColors))
                this.BotBuyButtons[1].Click()
            Return True
        }
    Default:
        {
            Return False
        }
    }
    Return False

}

UpgradeAll()
{
    if (!this.IsOn or !this.OpenUpdatesTab())
    return False

Loop 3
    this.UpdateAllButton.Click()

return True
}

CompleteAllQuests()
{
    if (!this.IsOn or !this.OpenQuestsTab())
    return False

QBs := this.QuestButtonsNoBar
if (this.TopScrollQuestButton.CheckColors(EquipmentMenu.ScrollBarColors))
{
    this.TopScrollQuestButton.Click(200,100)
    QBs := this.QuestButtonsBar
}
Loop 5
{
    For Index, QButton in QBs
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

return True
}

CheckQuestUpdates()
{
    if (!this.IsOn or (!this.IsOpen and !this.IsUpdated) or !this.OpenMenu() or this.QuestsTabButton.CheckColors(EquipmentMenu.TabButtonColors))
    return False
return True
}
}
