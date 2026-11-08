import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io 
import qs.themes

PanelWindow {
    id: root
    anchors {
        top: true
        left: true
    }
    color:"transparent"
    
    Rectangle {
        anchors.fill:   parent
        border.width:   Themes.borderwidth
        border.color:   Themes.bordercolor
        color:          Themes.widgetcolor
        radius:         Themes.radius
    }
}
