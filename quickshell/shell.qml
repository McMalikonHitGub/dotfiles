import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.themes
import qs.floatings

Scope {
    Variants {
        model: Quickshell.screens
        Loader {
            anchors.fill: parent
            required property var modelData

            sourceComponent:
                Themes.theme_number === 0 ? theme_1 :
                Themes.theme_number === 1 ? theme_1 :
                Themes.theme_number === 2 ? theme_1 :
                null
            onLoaded: {
                item.screen = modelData
            }
        }
    }
    WorkspaceIndicator {}
    Menu{}
    SuperWorkspaceSwitcher{}
    Cpu{}
    Ram{}
    Net{}
    Audio{}
    Wlogout{}


    Component {
        id: theme_1
        Theme_1 {}
    }
    
    Component {
        id: theme_2
        Theme_2 {}
    }

    Component {
        id: theme_3
        Theme_3 {}
    }

}


