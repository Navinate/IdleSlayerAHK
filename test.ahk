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
