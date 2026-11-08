import Quickshell
import Quickshell.Io 
import QtQuick

import qs.themes

TextWidget {
    id: root
    inhalt: " " + brightness
    color: "transparent"
    property real brightness: 0
    Process {
        id: get_brightness
        command: ["brightnessctl","info"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const raw = this.text.trim()
                const row = raw.split("\n")
                const brightness = row[1].split(" ")
                const res = brightness[3].split("(")[1].split(")")[0].split("%")[0]
                root.brightness = res
            }
        }
    }

    Rectangle {
        height: root.height - 2*Themes.borderwidth
        width: (root.width - 2*Themes.borderwidth) * root.brightness/100
        color: Themes.widgetcolor
        x: Themes.borderwidth
        y: Themes.borderwidth
        z: -1
    }

    IpcHandler {
            target: "brightness"
            function update(): void {
                get_brightness.running = true
            }
        }
}
