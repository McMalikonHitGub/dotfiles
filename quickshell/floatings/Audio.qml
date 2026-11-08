import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io 
import qs.themes
import qs.singletons


FloatingWidget {
    visible: Visible.sound
    margins.left: Position.sound
    Text {
        text: "Audio"
    }
}
