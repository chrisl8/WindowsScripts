gameName := "Hierarchical Finite State Machine (DEBUG)"

HoldKey(key, time)
{
    Send "{" key " down}"
    Sleep time
    Send "{" key " up}"
}

if WinWait(gameName, , 10)
{
    WinActivate gameName

    HoldKey("r", 10)
    HoldKey("f", 10)
    HoldKey("x", 10)
    HoldKey("space", 10)

    HoldKey("r", 10)
    HoldKey("f", 10)
    HoldKey("x", 10)
    HoldKey("space", 10)

    HoldKey("w", 1000)
    HoldKey("a", 1000)
    HoldKey("s", 1000)
    HoldKey("d", 1000)

    HoldKey("r", 10)
    HoldKey("f", 10)
    HoldKey("x", 10)
    HoldKey("space", 10)

    WinClose gameName ; Close the game when done.
}