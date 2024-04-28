gameName := "TileMap Layers (DEBUG)"

HoldKey(key, time)
{
    Send "{" key " down}"
    Sleep time
    Send "{" key " up}"
}

if WinWait(gameName, , 10)
{
    WinActivate gameName

    HoldKey("d", 1000)
    HoldKey("a", 1000)

    HoldKey("a", 1000)
    HoldKey("d", 1000)

    HoldKey("d", 1000)
    HoldKey("a", 1000)

    HoldKey("a", 1000)
    HoldKey("d", 1000)

    HoldKey("d", 1000)
    HoldKey("a", 1000)

    HoldKey("a", 1000)
    HoldKey("d", 1000)

    HoldKey("w", 500)

    WinClose gameName ; Close the game when done.
}