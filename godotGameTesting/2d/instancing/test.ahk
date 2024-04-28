gameName := "Scene Instancing Demo (DEBUG)"

if WinWait(gameName, , 10)
{
    WinActivate gameName

    MouseMove 63, 187
    Click
    Sleep 500

    MouseMove 370, 243
    Click
    Sleep 500

    MouseMove 788, 201
    Click
    Sleep 500

    MouseMove 1040, 182
    Click
    Sleep 500

    MouseMove 978, 14
    Click
    Sleep 500

    MouseMove 817, 587
    Click
    Sleep 500

    MouseMove 185, 3
    Click
    Sleep 500

    Sleep 5000

    WinClose gameName ; Close the game when done.
}