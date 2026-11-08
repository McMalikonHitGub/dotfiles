import Quickshell
import QtQuick
import qs.singletons
import qs.themes

TextWidget {
    id:             root
    inhalt:         "󰁹 " + Power.batteryPercent + "%"
    color:          "transparent"
    Rectangle {
        height: root.height - 2*Themes.borderwidth
        width: (root.width - 2*Themes.borderwidth) * Power.batteryPercent/100
        color: Themes.widgetcolor
        x: Themes.borderwidth
        y: Themes.borderwidth
        z: -1
    }
}
 
