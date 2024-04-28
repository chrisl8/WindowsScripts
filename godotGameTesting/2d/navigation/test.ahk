gameName := "Navigation Polygon 2D (DEBUG)"

if WinWait(gameName, , 10)
{
    WinActivate gameName

    MouseMove 635, 261
    Click
    Sleep 5000

    MouseMove 184, 485
    Click
    Sleep 5000

    MouseMove 662, 512
    Click
    Sleep 5000

    MouseMove 212, 127
    Click
    Sleep 5000

    WinClose gameName ; Close the game when done.
}