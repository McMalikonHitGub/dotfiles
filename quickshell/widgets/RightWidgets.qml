import Quickshell
import QtQuick
import qs.singletons
import qs.themes

Row {
    spacing:    Themes.gap
    Battery{id:bat}
    Network{id:net}
    Sound{id:sou}
    Brightness{id:bri}
    Clock{id:clo}
    Wlogout{id:wlo}
    property real custom_x:     parent.width - bat.width - net.width - sou.width -bri.width - clo.width - wlo.width - 5*Themes.gap
    property int custom_y:      (Themes.barheight - height)/2
    property int wlogout_pos:   custom_x+wlo.x
    property int network_pos:   custom_x+net.x
}
