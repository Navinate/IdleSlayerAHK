#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include, Utils.ahk

Class PixelInfo
{
    X := 0
    Y := 0
    ColorID := 0x000000

    __New(X, Y, InitColor := False)
    {
        ColorID := ""
        if (InitColor)
            PixelGetColor, ColorID, X, Y

        this.X := X
        this.Y := Y
        this.ColorID := ColorID
    }

    CheckColor(ColorID := "")
    {
        if (!ColorID)
            ColorID := this.ColorID
        if (this.GetColor() == ColorID)
            return True
        return False
    }

    CheckColors(ColorIDs)
    {
        for Index, Value in ColorIDs
        {
            if (this.CheckColor(Value))
                return True
        }
        return False
    }

    SearchColorAround(ColorID, DX, DY)
    {
        PixelSearch, PX, PY, this.X - DX, this.Y - DY, this.X + DX, this.Y + DY, ColorID, 0, Fast
        if ErrorLevel
            return
        return (New PixelInfo(PX, PY))
    }

    SearchColorsAround(ColorIDs, DX, DY)
    {
        for Index, Value in ColorIDs
        {
            PI := this.SearchColorAround(Value, DX, DY)
            if PI
                return PI
        }
        return
    }

    GetColor()
    {
        PixelGetColor, TempColorID, this.X, this.Y
        return TempColorID
    }

    Click(Delay := 50, Hold := 50)
    {
        ClickAt(this.X, this.Y, Delay, Hold)
    }

    MouseMove()
    {
        MouseMove, this.X, this.Y, 0
    }
}

SearchAndInit(X1, Y1, X2, Y2, ColorID, Description := "Pixel", Variation:=10, Mode:="Fast")
{
    PixelSearch, PixelX, PixelY, X1, Y1, X2, Y2, ColorID, %Variation%, %Mode%
    if ErrorLevel
    {
        MsgBox, Cant find %Description%.
        return
    }
    return New PixelInfo(PixelX, PixelY, True)
}