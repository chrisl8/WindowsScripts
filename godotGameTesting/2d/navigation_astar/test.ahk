gameName := "Grid-based Pathfinding with AStarGrid2D (DEBUG)"

if WinWait(gameName, , 10)
{
    WinActivate gameName

    MouseMove 860, 501
    Click
    Sleep 10000

    MouseMove 166, 347
    Click
    Sleep 9000

    MouseMove 1034, 83
    Click
    Sleep 5000

    MouseMove 108, 612
    Click
    Sleep 10000

    WinClose gameName ; Close the game when done.
}