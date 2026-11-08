import Quickshell
import QtQuick
import qs.singletons
import qs.themes

Rectangle {
    id: rect
    property bool hovered:  mouse.containsMouse      
    function enter() {}
    function exit() {}
    function click() {}
    
    default property alias content: contentItem.data

    Item {
        id: contentItem
        anchors.centerIn: parent
    }

    implicitWidth: contentItem.childrenRect.width + 10 < implicitHeight ? implicitHeight : contentItem.childrenRect.width + 10
    implicitHeight: Themes.barheight

    MouseArea {
        id:                 mouse
        anchors.fill:       parent            
        acceptedButtons:    PointerDevice.Mouse | PointerDevice.TouchPad
        cursorShape:        Qt.PointingHandCursor
        hoverEnabled:       true
        onEntered: { enter() }
        onExited: { exit() }
        onClicked: { click() }
    }
    border.color: Themes.bordercolor
    border.width: Themes.borderwidth
    color: mouse.containsMouse ? Themes.hovercolor : Themes.widgetcolor
    radius: Themes.radius
}
