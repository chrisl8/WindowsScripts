gameName := "Bullet Shower (DEBUG)"

if WinWait(gameName, , 10)
 {
    WinActivate gameName
    Sleep 500 ; Let the game get started so we do hit some bullets.

    ; Just move the mouse around a bit
    MouseMove 1000, 145
    Sleep 1500

    MouseMove 200, 135
    Sleep 1500

    MouseMove 950, 550
    Sleep 1500

    MouseMove 150, 550
    Sleep 1500

    WinClose gameName ; Close the game when done.
}