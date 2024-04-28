gameName := "Isometric Game (DEBUG)"

HoldKey(key, time)
{
    Send "{" key " down}"
    Sleep time
    Send "{" key " up}"
}

if WinWait(gameName, , 10)
{
    WinActivate gameName

    HoldKey("s", 1500)
    HoldKey("a", 1500)
    HoldKey("s", 1500)
    HoldKey("d", 1500)
    HoldKey("w", 500)
    HoldKey("d", 1500)
    HoldKey("s", 1500)
    HoldKey("w", 1500)
    HoldKey("d", 2000)
    HoldKey("s", 1500)
    HoldKey("a", 1500)
    HoldKey("s", 1500)
    HoldKey("a", 1500)
    HoldKey("s", 1500)
    HoldKey("a", 1500)

    WinClose gameName ; Close the game when done.
}