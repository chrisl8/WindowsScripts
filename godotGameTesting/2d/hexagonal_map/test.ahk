gameName := "Hexagonal Game (DEBUG)"

HoldKey(key, time)
{
    Send "{" key " down}"
    Sleep time
    Send "{" key " up}"
}

if WinWait(gameName, , 10)
{
    WinActivate gameName

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

    WinClose gameName ; Close the game when done.
}