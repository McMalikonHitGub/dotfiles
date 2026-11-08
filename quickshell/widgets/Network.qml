import Quickshell
import QtQuick
import Quickshell.Io 
import qs.singletons
import qs.themes
TextWidget{
    id:             root
    inhalt:         "net"
    Timer {
        id: networkvisTimer
        interval: 500
        repeat: false
        onTriggered: {
            Themes.networkmenu_vis = false
        }
    }

    function click() {
        if (Themes.networkwidget_is_x) {
            networkvisTimer.restart()
            Themes.networkwidget_is_x   = false
            Themes.networkscan          = false
        } else {
            Themes.networkwidget_is_x   = true
            Themes.networkmenu_vis      = true
            Themes.networkscan          = true
        }
    }
}



