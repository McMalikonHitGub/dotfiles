import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import qs.themes

ShellRoot {
    Variants {
        model: Quickshell.screens

PanelWindow {
    id: floatingWindow
    required property var modelData
    screen: modelData

    anchors {
        right:      true
        bottom:     true
    }

    margins {
        right:      Themes.barheight
        bottom:     Themes.barheight
    }

    implicitWidth:  50
    implicitHeight: 50


    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    mask: Region{}
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.3
        border.width: Themes.borderwidth
        border.color: Themes.bordercolor
        radius: Themes.radius
        Text {
            anchors.centerIn: parent
            color: Themes.textcolor
            text: {
                let monitor = Hyprland.monitorFor(modelData)
                return monitor.activeWorkspace ? monitor.activeWorkspace.id : ""
            }
            font.pixelSize: 20
        }
    }
}
}
}
