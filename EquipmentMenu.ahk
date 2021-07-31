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
    _IsOn := True

    static Green := 0x23AA11
    static Red := 0x1111AD

    __New(SRC)
    {
        this.SRC := SRC
        this.InitMenuButton()
        this.InitTabButtons()
        this.InitAscendButton()
        this.InitMinionButtons()
        this.CloseMenu()
        this._IsOn := False
    }

    InitMenuButton()
    {
        this.MenuButton := SearchAndInit(this.SRC.GetX(0.87), this.SRC.GetY(0.78), this.SRC.GetX(0.94), this.SRC.GetY(0.91), 0x929292, "EquipmentMenu Button")
    }

    InitTabButtons()
    {
        this.OpenMenu()

        X := this.SRC.GetX(0.66)
        Y := this.SRC.GetY(0.89)
        DeltaX := this.SRC.GetX(0.06)

        this.EquipmentTabButton := New PixelInfo(X, Y, True)

        X := X + DeltaX
        this.UpdatesTabButton := New PixelInfo(X, Y, True)

        X := X + DeltaX
        this.QuestsTabButton := New PixelInfo(X, Y, True)

        X := X + DeltaX
        this.JewelsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.StatsTabButton := New PixelInfo(X, Y)

        X := X + DeltaX
        this.CloseButton := New PixelInfo(X, Y, True)
    }

    InitInnerButtons()
    {
        this.OpenMenu()

        Y := this.SRC.GetY(0.81)
        this.Q1Button := New PixelInfo(this.SRC.GetX(0.76), Y)
        this.Q10Button := New PixelInfo(this.SRC.GetX(0.81), Y)
        this.Q50Button := New PixelInfo(this.SRC.GetX(0.86), Y)
        this.QMaxButton := New PixelInfo(this.SRC.GetX(0.92), Y)

        X := this.SRC.GetX(0.92)
        this.TopBuyButtons := []
        Loop 4
            this.TopBuyButtons.Push(New PixelInfo(X, this.SRC.GetY(0.25 + 0.13 * (A_Index - 1))))

        this.BotBuyButtons := []
        Loop 4
            this.BotBuyButtons.Push(New PixelInfo(X, this.SRC.GetY(0.72 - 0.13 * (A_Index - 1))))

        this.UpdateAllButton := this.Q10Button

        this.QuestButtons := []
        Loop 13
            this.QuestButtons.Push(New PixelInfo(X, this.SRC.GetY(0.35 + (A_Index - 1) * 0.04)))
    }

    Toggle()
    {
        this._IsOn := !this._IsOn
    }

    IsOpen[]
    {
        get
        {
            if (this.MenuButton.CheckColor())
            {
                this._IsOpen := False
                return False
            }
            if (!this.CloseButton.CheckColor())
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
            if (this.MenuButton.CheckColor() or this.IsOpen)
                return False
            return True
        }
    }

    OpenMenu(Delay := 150)
    {
        if (!this._IsOn)
            return

        this.MenuButton.Click(Delay)
        this.IsOpen := True
    }

    CloseMenu()
    {
        if (!this._IsOn)
            return

        this.CloseButton.Click()
        this.IsOpen := False
    }

    OpenEquipmentTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.EquipmentTabButton.Click()
    }

    OpenUpdatesTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.UpdatesTabButton.Click()
    }

    OpenQuestsTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.QuestsTabButton.Click()
    }

    OpenJewelsTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.JewelsTabButton.Click()
    }

    OpenStatsTab()
    {
        if (!this._IsOn)
            return

        this.OpenMenu()
        this.StatsTabButton.Click()
    }

    BuyAll()
    {
        if (!this._IsOn)
            return

        this.OpenEquipmentTab()

        MouseMove this.Q10Button.X, this.BotBuyButtons[2], 0

        Loop 20
            Send {WheelDown}
        Sleep 500

        Loop 3
        {
            For Index, Value in this.BotBuyButtons
            {
                if (!this._IsOn)
                    return
                Value.Click()
            }
            Loop 8 
                Send {WheelUp}

            Sleep 300
        }
        For Index, Value in this.TopBuyButtons
        {
            if (!this._IsOn)
                return
            Value.Click()
        }
    }

    UpdateAll()
    {
        if (!this._IsOn)
            return

        this.OpenUpdatesTab()

        Loop 3
            this.UpdateAllButton.Click()
    }

    CompleteAllQuests()
    {
        if (!this._IsOn)
            return

        this.OpenQuestsTab()

        MouseMove this.Q10Button.X, this.BotBuyButtons[2], 0

        Loop 20
            Send {WheelUp}
        Sleep 500

        Loop 5
        {
            For Index, Value in this.QuestButtons
            {
                if (!this._IsOn)
                    return
                if (Value.CheckColor(EquipmentMenu.Green))
                {
                    Value.Click()
                    MouseMove this.Q10Button.X, this.BotBuyButtons[2], 0
                }
            }
            Loop 8 
                Send {WheelDown}
            Sleep 300
        }
    }
}
