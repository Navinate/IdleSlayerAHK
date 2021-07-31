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
Return

F3::
    MouseGetPos, MouseX, MouseY
    PixelGetColor, Color, MouseX, MouseY
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