SetTimer WatchCursor, 100

WatchCursor()
{
    MouseGetPos &xpos, &ypos, &id, &control
    ToolTip
    (
        "ahk_id " id " x: " xpos " y: " ypos "
        ahk_class " WinGetClass(id) "
        " WinGetTitle(id) "
        Control: " control
    )
}