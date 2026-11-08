import Quickshell
import QtQuick
import qs.singletons
import qs.themes

Rectangle {
    id: root
    required property string    inhalt
    property bool hovered:      mouse.containsMouse      
    function enter() {}
    function exit() {}
    function click() {}

    implicitWidth:              text.implicitWidth > Themes.barheight ? text.implicitWidth+ 10 : implicitHeight
    implicitHeight:             Themes.barheight
    Behavior on width {
        NumberAnimation {duration:100}
    }
    MouseArea {
        id:                     mouse
        anchors.fill:           parent            
        acceptedButtons:        PointerDevice.Mouse | PointerDevice.TouchPad
        cursorShape:            Qt.PointingHandCursor
        hoverEnabled:           true
        onEntered:              { enter() }
        onExited:               { exit() }
        onClicked:              { click() }
    }

    Text {
        anchors.centerIn:   parent
        id:                 text
        font.family:        Themes.font[Themes.theme_number]
        font.pixelSize:     14
        color:              Themes.textcolor
        text:               root.inhalt
    }

    border.color:               Themes.bordercolor
    border.width:               Themes.borderwidth
    color:                      mouse.containsMouse ? Themes.hovercolor : Themes.widgetcolor
    radius:                     Themes.radius
}
