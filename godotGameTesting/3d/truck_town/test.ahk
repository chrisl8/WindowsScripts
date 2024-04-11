gameName := "Truck Town (DEBUG)"

if WinWait(gameName, , 10)
{
    WinActivate gameName

    ; Back button (Just in case game was already running. No harm if it is at main menu)
    MouseMove 56, 34
    Click

    ; Minivan
    MouseMove 234, 322
    Click
    Send "{w down}"
    Send "{a down}"
    Sleep 1400
    Send "{a up}"
    Sleep 8000
    Send "{w up}"
    MouseMove 56, 34
    Click

    ; Semi-Truck
    MouseMove 572, 322
    Click
    Send "{w down}"
    Send "{d down}"
    Sleep 1400
    Send "{d up}"
    Send "{a down}"
    Sleep 400
    Send "{a up}"
    Sleep 8000
    Send "{w up}"
    ; Back button
    MouseMove 56, 34
    Click

    ; Tow Truck w/ Impound
    MouseMove 912, 322
    Click
    Send "{w down}"
    Sleep 10000
    Send "{w up}"
    MouseMove 56, 34
    Click

    WinClose gameName ; Close the game when done.
}