import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io 
import qs.themes
import qs.singletons

FloatingWidget{
    margins.left:   Position.superwsswitcher
    visible:        Visible.superwsswitcher
    Text {
        text: "Super"
    }
}
