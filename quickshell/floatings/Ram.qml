import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io 
import qs.themes
import qs.singletons


FloatingWidget {
    visible: Visible.ram
    margins.left: Position.ram
    Text {
        text: "RAM"
    }
}
