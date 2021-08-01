#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#SingleInstance, Force
#MaxThreadsPerHotkey 3

Toggle := False
ClickToggle := True
AllToggle := False

RageToggle := False
BonusToggle := False
SilverToggle := False
PortalToggle := False

AscentionToggle := False
MinionsToggle := False
ItemsToggle := False
OldItemsToggle := False
UpgradesToggle := False

ChestHuntToggle := False
JumpToggle := False
BottomToggle := False

BoostToggle := False

BuyPeriod := 3
BuyMaximum := False

#IfWinNotActive Idle Slayer
    ~LButton:: Toggle := False
#IfWinNotActive

#IfWinActive Idle Slayer
    ~RButton:: Toggle := False

    R:: RageToggle := !RageToggle
    ^R:: Rage(True)

    B:: BonusToggle := !BonusToggle
    ^B:: BonusLevel(True)

    S:: SilverToggle := !SilverToggle
    ^S:: Silver(True)

    P:: PortalToggle := !PortalToggle
    ^P:: Portal(True)

    A:: AscentionToggle := !AscentionToggle
    ^A:: Ascention(True)

    M:: MinionsToggle := !MinionsToggle
    ^M:: Minions(True)

    I:: ItemsToggle := !ItemsToggle
    ^I:: Items(True)

    ^L:: LastItem(True)

    O:: OldItemsToggle := !OldItemsToggle
    ^O:: OldItems(True)

    U:: UpgradesToggle := !UpgradesToggle
    ^U:: Upgrades(True)

    H:: 
        ChestHuntToggle := !ChestHuntToggle
        JumpToggle := False
        BottomToggle := False
    Return
    ^H:: ChestHunt(True)

    J:: 
        ChestHuntToggle := False
        JumpToggle := !JumpToggle
        BottomToggle := False
    Return
    ^J:: Jump(True)

    N:: 
        ChestHuntToggle := False
        JumpToggle := False
        BottomToggle := !BottomToggle
    Return
    ^N:: Bottom(True)

    Z:: BoostToggle := !BoostToggle
    ^Z:: Boost(True)

    C:: ClickToggle := !ClickToggle

    W::
        AllToggle := !AllToggle
        If (AllToggle)
        {
            ClickToggle := True
            RageToggle := True
            BonusToggle := True
            SilverToggle := True
            MinionsToggle := True
            ItemsToggle := True
            OldItemsToggle := True
            UpgradesToggle := True
            ChestHuntToggle := True
            JumpToggle := False
            BottomToggle := False
            BoostToggle := True
            ItemsToggle := True
            OldItemsToggle := True
            UpgradesToggle := True
            AscentionToggle := True
            PortalToggle := True
            Return
        }
        ChestHuntToggle := False
        RageToggle := False
        BonusToggle := False
        SilverToggle := False
        MinionsToggle := False
        ItemsToggle := False
        OldItemsToggle := False
        UpgradesToggle := False
        BoostToggle := False
        ItemsToggle := False
        OldItemsToggle := False
        UpgradesToggle := False
        AscentionToggle := False
        PortalToggle := False
    Return

    ClickAt(x, y)
    {
        MouseMove x, y, 0
        Click
        Sleep 50
    }

    ChestHunt(Forced:=False)
    {
        global Toggle
        global ChestHuntToggle
        global ClickToggle

        Loop , 3
        {
            y := A_Index * 100 + 200
            Loop , 10
            {
                If (!Forced And (!Toggle Or !ClickToggle Or !ChestHuntToggle))
                    Return

                x := A_Index * 100 + 100

                MouseMove x, y, 0
                Click Left, Down
                Sleep A_Index * 20 - 10
                Click Left, Up

                Boost()
                Sleep 100
            }
        }

        ClickAt(630, 690)
    }

    Jump(Forced:=False)
    {
        global Toggle
        global JumpToggle

        Loop 3
        {
            Loop 10
            {
                If (!Forced And (!Toggle Or !JumpToggle))
                    Return

                Send {Space Down}
                Sleep A_Index * 20 - 10
                Send {Space Up}

                Boost()
                Sleep 100
            }
        }
    }

    Bottom(Forced:=False)
    {
        global Toggle
        global BottomToggle

        Loop 2 {

            If (!Forced And (!Toggle Or !BottomToggle))
                Return

            Boost()
            Sleep 1500

            Send {Space Down}
            Sleep 100
            Send {Space Up}

            Boost()

        }

    }

    Ascention(Forced:=False)
    {
        global Toggle
        global ClickToggle
        global AscentionToggle
        global BuyPeriod
        global BuyMaximum

        If (!Forced And (!Toggle Or !ClickToggle Or !AscentionToggle))
            Return

        BuyPeriod := 1
        BuyMaximum := True

        ClickAt(100, 100)
        Sleep 100
        ClickAt(100, 680)
        ClickAt(300, 600)
        Sleep 200
        ClickAt(600, 600)
    }

    Minions(Forced:=False)
    {
        global Toggle
        global ClickToggle
        global MinionsToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !MinionsToggle))
            Return

        ClickAt(100, 100)
        Sleep 100

        ClickAt(330, 680)

        MouseMove 330, 400, 0
        Loop , 7 {
            Send {WheelUp}
        }
        Sleep 500

        ; Skeleton
        ClickAt(500, 300)
        ClickAt(500, 300)

        ; Knight
        ClickAt(500, 450)
        ClickAt(500, 450)

        ; Goo
        ClickAt(500, 600)
        ClickAt(500, 600)

        Loop , 7 {
            Send {WheelDown}
        }
        Sleep 500

        ; Wizard
        ClickAt(500, 425)
        ClickAt(500, 425)

        ; Golem
        ClickAt(500, 575)
        ClickAt(500, 575)

        ClickAt(575, 660)
    }

    BonusLevel(Forced:=False)
    {
        global Toggle
        global BonusToggle
        global ClickToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !BonusToggle))
            Return

        ClickAt(670, 595)
    }

    Rage(Forced:=False)
    {
        global Toggle
        global RageToggle
        global ClickToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !RageToggle))
            Return

        ClickAt(1100, 150)
    }

    Silver(Forced:=False)
    {
        global Toggle
        global SilverToggle
        global ClickToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !SilverToggle))
            Return
        ClickAt(630, 45)
    }

    Portal(Forced:=False)
    {
        global Toggle
        global PortalToggle
        global ClickToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !PortalToggle))
            Return

        ClickAt(1200, 150)
        Sleep 200
        ClickAt(600, 600)
    }

    Boost(Forced:=False)
    {
        global Toggle
        global BoostToggle

        If (!Forced And (!Toggle Or !BoostToggle))
            Return
        Send {Shift Down}
        Sleep 20
        Send {Shift Up}
    }

    Items(Forced:=False)
    {
        ; BowItem(Forced)
        LastItem(Forced)
    }

    LastItem(Forced:=False)
    {
        global Toggle
        global ClickToggle
        global ItemsToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !ItemsToggle))
            Return

        ClickAt(1200, 660)
        Sleep 200
        ClickAt(850, 660)
        ClickAt(1200, 625)

        MouseMove 1000, 400, 0
        Loop , 20 {
            Send {WheelDown}
        }
        Sleep 500

        ClickAt(1200, 550)
        ClickAt(1250, 660)
    }

    BowItem(Forced:=False)
    {
        global Toggle
        global ClickToggle
        global ItemsToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !ItemsToggle))
            Return

        ClickAt(1200, 660)
        Sleep 200
        ClickAt(850, 660)
        ClickAt(1050, 625)

        MouseMove 1000, 400, 0
        Loop , 20 {
            Send {WheelUp}
        }
        Sleep 500
        Loop, 16 {
            Send {WheelDown}
        }
        Sleep 200
        ClickAt(1200, 250)
        ClickAt(1250, 660)
    }

    OldItems(Forced:=False)
    {
        global Toggle
        global ClickToggle
        global OldItemsToggle
        global BuyMaximum

        If (!Forced And (!Toggle Or !ClickToggle Or !OldItemsToggle))
            Return

        ClickAt(1200, 660)
        Sleep 200

        ClickAt(850, 660)
        If (!BuyMaximum)
            ClickAt(1100, 625)
        Else 
            ClickAt(1200, 625)

        MouseMove 1000, 400, 0
        Loop , 20 {
            Send {WheelDown}
        }
        Sleep 500

        Loop 3
        {
            AddY := A_Index * 10 + 40
            Loop 4
            {
                ClickAt(1200, (6 - A_Index) * 100 + AddY )
                If (!Forced And (!Toggle Or !ClickToggle Or !OldItemsToggle))
                    Break
            }
            If (!Forced And (!Toggle Or !ClickToggle Or !OldItemsToggle))
                Break
            Loop , 8 {
                Send {WheelUp}
            }
            Sleep 300
        }
        Loop 4
        {
            ClickAt(1200, (6 - A_Index) * 100 + 20 )
        }

        ClickAt(1250, 660)
    }

    Upgrades(Forced:=False)
    {
        global Toggle
        global ClickToggle
        global UpgradesToggle

        If (!Forced And (!Toggle Or !ClickToggle Or !UpgradesToggle))
            Return

        ClickAt(1200, 660)
        Sleep 200
        ClickAt(950, 660)

        ClickAt(1000, 625)
        ClickAt(1000, 625)
        ClickAt(1000, 625)
        ClickAt(1250, 660)
    }

    Q::
        MouseGetPos MouseX, MouseY
        PixelGetColor CurColor, %MouseX%, %MouseY%
        MsgBox, , Color, X=%MouseX%`,Y=%MouseY%`, Color is %CurColor%
    Return

    F2::
        Toggle := !Toggle
        Loop
        {
            If (!Toggle)
                Return
            Loop 10
            {
                Loop 50
                {
                    Jump()
                    Bottom()

                    ChestHunt()
                    Rage()
                    BonusLevel()
                    Silver()
                    Portal()

                    If (Mod(A_Index, BuyPeriod * 3) == 0)
                        Upgrades()

                    If (Mod(A_Index, BuyPeriod * 3) == BuyPeriod * 1)
                        OldItems()

                    If (Mod(A_Index, BuyPeriod * 3) == BuyPeriod * 2)
                        Items()

                    Boost()
                }
                Minions() 
                BuyPeriod := 3
                BuyMaximum := False
            }
            Ascention()
        }
    Return
#IfWinActive