gameName := "Dodge the Creeps (DEBUG)"

HoldKey(key, time)
{
    Send "{" key " down}"
    Sleep time
    Send "{" key " up}"
}

if WinWait(gameName, , 10)
{
    WinActivate gameName

    ; Just move the mouse around a bit
    MouseMove 230, 570
    Click
    Sleep 100

    HoldKey("w", 500)
    HoldKey("a", 500)
    HoldKey("s", 500)
    HoldKey("d", 500)

    HoldKey("w", 500)
    HoldKey("d", 500)
    HoldKey("s", 500)
    HoldKey("a", 500)

    HoldKey("w", 500)
    HoldKey("a", 500)
    HoldKey("s", 500)
    HoldKey("d", 500)

    HoldKey("w", 500)
    HoldKey("d", 500)
    HoldKey("s", 500)
    HoldKey("a", 500)

    HoldKey("w", 500)
    HoldKey("a", 500)
    HoldKey("s", 500)
    HoldKey("d", 500)

    MouseMove 230, 570
    Click
    Sleep 1500

    HoldKey("w", 500)
    HoldKey("a", 500)
    HoldKey("s", 500)
    HoldKey("d", 500)

    HoldKey("w", 500)
    HoldKey("d", 500)
    HoldKey("s", 500)
    HoldKey("a", 500)

    HoldKey("w", 500)
    HoldKey("a", 500)
    HoldKey("s", 500)
    HoldKey("d", 500)

    MouseMove 230, 570
    Click
    Sleep 1500

    WinClose gameName ; Close the game when done.
}