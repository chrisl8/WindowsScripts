gameName := "Glow for 2D (DEBUG)"

if WinWait(gameName, , 10)
 {
    WinActivate gameName

    MouseClickDrag "left", 980, 390, 20, 390
    Sleep 1000

    MouseClickDrag "left", 20, 390, 980, 390
    Sleep 1000

    WinClose gameName ; Close the game when done.
}