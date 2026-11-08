import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Window
import QtQuick.Controls

import qs.singletons
import qs.themes

Rectangle {
    id:root
    height: Themes.barheight
    width: row.width
    color: "transparent"
    HoverHandler {
        id: mouse
    }

    property var programs: [
        {
            program:        "cpu",
            icon:       "",
            color:      "white"
        },
        {
            program:    "ram",
            icon:       "",
            color:      "white"
        },
        {
            program:    "update",
            icon:       "󰚰",
            color:      "white"
        }
    ]
    Row {
        id: row
        property bool extended

        spacing: Themes.gap

        TextWidget {
            visible: true
            inhalt: "󰣇"
        }

        Repeater {
            model:                  root.programs
            TextWidget {
                id:w
                required property var modelData
                required property real index
                property bool vis
                inhalt:             modelData.icon
                visible:            mouse.hovered ? vis : false
                property string visible_changer: modelData.program

                function click() {
                    console.log(w.x)
                    if (modelData.program == "cpu") {
                        Visible.cpu = !Visible.cpu
                    } else if (modelData.program == "ram") {
                        Visible.ram = ! Visible.ram
                    } else if (modelData.program == "update") {
                        Visible.update = !Visible.update
                    }
                }
                
                Connections {
                    target:         mouse
                    function onHoveredChanged() {
                        if (modelData.program == "cpu") {
                            Position.cpu=w.x
                        } else if (modelData.program == "ram") {
                            Position.ram=w.x
                        } else if (modelData.program == "update") {
                            Position.update=w.x
                        }
                    }
                }
                Connections {
                    target: mouse
                    function onHoveredChanged() {

                        if (mouse.hovered) {
                            visTimer.restart()
                        } else {
                            visTimer.stop()
                            vis =   false
                        }
                    }
                }

                Timer {
                    id:             visTimer
                    interval:       index*100
                    repeat:         false
                    running:        mouse.hovered
                    onTriggered: {
                        vis =       true
                    }
                }

                Behavior on width {
                    NumberAnimation {duration:100}
                }
            }
        }
    }
}
