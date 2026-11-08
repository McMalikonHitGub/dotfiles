import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.singletons

PanelWindow {
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    id:bar
    color: Themes.barcolor

    margins{
        right: 0
        left: 0
        top: 0
        bottom: 0
    }

    anchors {
        top: true
        right: true
        left: true
        bottom: false
    }

    implicitHeight: Themes.barheight
    Stats{}
    SuperWorkspaces{anchors.centerIn: parent}
    RightWidgets{
        id:rightwid 
        x: custom_x
        y: custom_y
    }
}
