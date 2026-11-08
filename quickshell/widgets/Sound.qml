import Quickshell
import Quickshell.Io
import QtQuick
import qs.singletons
import qs.themes

TextWidget {
    id: root
    inhalt: ""
    property var d: 0


    function click() {
        mute.running = true
        Visible.sound = !Visible.sound
        Position.sound = root.parent.x + root.x
    }
    color: "transparent"

    Rectangle {
        height: root.height - 2*Themes.borderwidth
        width: (root.width - 2*Themes.borderwidth) * root.d/100
        color: Themes.widgetcolor
        x: Themes.borderwidth
        y: Themes.borderwidth
        z: -1
    }

    Process {
        id: get_volume
        command: ["wpctl","get-volume","@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const raw   = this.text.trim()
                const res   = raw.split(" ")
                if (res[1].split(".")[0] == "0") {
                    root.d      = res[1].split(".")[1]
                } else {
                    if (res[1].split(".")[0] == "1") {
                        if (res[1].split(".")[1] == "00") {
                            root.d = 100
                        }
                    }
                }
                if (res[2]   == "[MUTED]") {
                    root.inhalt = " " + res[1]
                } else {
                    root.inhalt = " " + res[1]
                }
            }
        }
    }
    IpcHandler {
        target: "audio"
        function update(): void{
            get_volume.running = true
        }
    }
}
