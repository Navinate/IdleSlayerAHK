#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

F2::
    WinGetPos, , , Width, Height, Idle Slayer
    X1 := Floor(Width * 0.03)
    DeltaX1 := Floor(Width * 0.08)
    DeltaX2 := Floor(Width * 0.01)
    Y1 := Floor(Width * 0.86)
    Y2 := Floor(Width * 0.94)
    MsgBox % Width " " Height
Return

F3::
    MouseGetPos, MouseX, MouseY
    PixelGetColor, Color, (MouseX + 50), MouseY
    MsgBox %MouseX% %MouseY% - %Color%
Return

F5::
    X2 := X1 + DeltaX1
    MsgBox %X1% %Y1% %X2% %Y2%
    PixelSearch, PixelX, PixelY, X1, Y1, X2, Y2, 0xB328A3, 20, Fast
    if ErrorLevel
        MsgBox, That color was not found in the specified region.
    else
        MsgBox, A color was found at X%PixelX% Y%PixelY%.
Return

F4::
    Send {WheelDown}
Return

F6::
    PostMessage, 0x20A, 1<<16, 0,, A
Return

F7:: ; Scroll right.
F8:: ; Scroll left.
    (A_ThisHotkey!=A_PriorHotkey||A_TimeSincePriorHotkey>450)? rNotch:=1: (rNotch<20)? rNotch++: rNotch+=3
    ControlGetFocus, fcontrol, A
    if (A_ThisHotkey = "F8")
        Loop % rNotch ; <-- Increase this value to scroll faster.
        SendMessage, 0x115, 0, 0, %fcontrol%, A ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.
    if (A_ThisHotkey = "F7")
        Loop % rNotch ; <-- Increase this value to scroll faster.			
        SendMessage, 0x115, 1, 0, %fcontrol%, A ; 0x114 is WM_HSCROLL and t	he 0 after it is SB_LINELEFT.
return