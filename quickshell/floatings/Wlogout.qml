import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import Quickshell.Io
import qs.widgets
import qs.themes
import qs.singletons


FloatingWidget {
    id: root
    visible: Visible.wlogout
    margins.left: Position.wlogout
    width: 100
    property list<var> placeholder: [
        {
            text: "shutdown",
            command: ["shutdown","now"]
        },{
            text: "reboot",
            command: ["reboot"]
        },{
            text: "lock",
            command: ["hyprlock"]
        }
    ]

    Column {
        Repeater {
            model: placeholder
            TextWidget {
                required property var modelData
                inhalt: modelData.text
                width: root.width
                height: root.height/root.placeholder.length
                function click() {
                    proc.running = true
                    Visible.wlogout = false
                }
                Process {
                    id: proc
                    command: modelData.command
                    running: false
                }
            }
        }
    }
}
