import Quickshell
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io
import qs.singletons
import qs.themes

TextWidget {
    id: root
    inhalt:         "wlogout"
    width: 100
    function click() {
        Visible.wlogout     = !Visible.wlogout
        Position.wlogout    = parent.x + root.x
    }
}
