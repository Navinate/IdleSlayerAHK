#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include, Utils.ahk

Class PixelInfo
{
    X := 0
    Y := 0
    ColorID := 0x000000

    __New(X, Y, InitColor := False, ColorID := "")
    {
        if (InitColor and !ColorID)
            PixelGetColor, ColorID, X, Y

        this.X := X
        this.Y := Y
        this.ColorID := ColorID
    }

    CheckColor()
    {
        PixelGetColor, TempColorID, this.X, this.Y
        CID := this.ColorID
        If (TempColorID == this.ColorID)
            Return True
        Return False
    }

    Click(Delay := 50)
    {
        ClickAt(this.X, this.Y, Delay)
    }
}

SearchAndInit(X1, Y1, X2, Y2, ColorID, Description := "Pixel", Variation:=10, Mode:="Fast")
{
    PixelSearch, PixelX, PixelY, X1, Y1, X2, Y2, ColorID, %Variation%, %Mode%
    if ErrorLevel
    {
        MsgBox, Cant find %Description%.
        Return
    }
    Return New PixelInfo(PixelX, PixelY, True)
}