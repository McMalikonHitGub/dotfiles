import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Shapes 1.11
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.widgets
import qs.widgets.menuwidgets
import qs.themes

PanelWindow {
    id: floatingWindow

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    margins {
        top: 200
        left: 500
        right:500
        bottom: 200
    }

    implicitWidth: 300
    implicitHeight: 300
    visible: false
    color: "transparent"
    focusable: true
    
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    property var wps : [] 


    Column {
        id: rootmenu
        anchors.centerIn: parent

        TextWidget {
            id:theme_button
            inhalt: "Themawechsel bitte!"
            width: floatingWindow.width
            height: floatingWindow.height/4
            function click() {
                if (Themes.theme_number == 0) {
                    Themes.theme_number = 1 
                } else if (Themes.theme_number == 1) {
                    Themes.theme_number = 2 
                } else if (Themes.theme_number == 2) {
                    Themes.theme_number = 0 
                }
            }
        }
        TextWidget {
            id: programsbutton
            inhalt: "work in progress..."

            width: floatingWindow.width
            height: floatingWindow.height/4

            function click() {
                rootmenu.visible                = false
                floatingWindow.margins.top      = 5
                floatingWindow.margins.bottom   = 5
                floatingWindow.margins.left     = 5
                floatingWindow.margins.right    = 5

                circ.vis                        = true

            }


        }
        
        TextWidget {
            id: themesbutton
            required property var modelData
            inhalt: "Wallpaper"
            width: floatingWindow.width
            height: floatingWindow.height/4



            function click() {
                floatingWindow.margins.top = 150
                floatingWindow.margins.bottom = 150
                floatingWindow.margins.left = 5
                floatingWindow.margins.right = 5
                rootmenu.visible = false

                wprow.visible = true
                getwps.running = true
            }

            Process {
                id: getwps
                command: ["ls","/home/malik/Images/wp/"]

                stdout: StdioCollector {
                    onStreamFinished: {
                        const raw = this.text.trim()
                        const w = raw.split("\n")
                        floatingWindow.wps = w
                    }
                }
            }
        }

        TextWidget {
            id: networkbutton
            required property var modelData
            inhalt: "Network"
            width: floatingWindow.width
            height: floatingWindow.height/4
        }
    }
    WallpaperSwitcher {
        id: wprow
        wps: floatingWindow.wps
    }
    CircleDummy {
        id: circ
        vis: false
    }
    IpcHandler {
        target: "floatingWindow"

        function toggle(): void {
            floatingWindow.visible          = !floatingWindow.visible
            floatingWindow.margins.top      = 200
            floatingWindow.margins.bottom   = 200
            floatingWindow.margins.left     = 500
            floatingWindow.margins.right    = 500
            floatingWindow.visible = !floatingWindow.visible
            floatingWindow.margins.top = 300
            floatingWindow.margins.bottom = 300
            floatingWindow.margins.left = 800
            floatingWindow.margins.right = 800

            rootmenu.visible                = true
            wprow.visible                   = false
            circ.vis                        = false
        }
        function back(): void {
            //base stats
            floatingWindow.margins.top = 200
            floatingWindow.margins.bottom = 200
            floatingWindow.margins.left = 500
            floatingWindow.margins.right = 500

            rootmenu.visible = true
            wprow.visible = false
            circ.vis = false
            floatingWindow.visible          = !floatingWindow.visible
            floatingWindow.margins.top      = 200
            floatingWindow.margins.bottom   = 200
            floatingWindow.margins.left     = 500
            floatingWindow.margins.right    = 500

            rootmenu.visible                = true
            wprow.visible                   = false
            circ.vis                        = false
        }
    }
}
