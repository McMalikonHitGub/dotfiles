import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io 
import QtQuick
import QtQuick.Layouts

import qs.themes

Row {
    id: root
    spacing: Themes.gap
    anchors.centerIn: parent


    property var superworkspaces: [
        {
            name:       "󰬘",
            workspaces: [1,2,3,4,5,6,7,8,9,10]
        },
        {
            name:       "󰑴",
            workspaces: [11,12,13,14,15,16,17,18,19,20]
        },
        {
            name:       "",
            workspaces: [21,22,23,24,25,26,27,28,29,30]
        }
    ]

    property real activesuperworkspace: 0

    Rectangle {
        id: rectangleSuperWorkspaceSwitcher
        implicitWidth: superWorkspaceRow.width 
        height: Themes.barheight
        color: "transparent"
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 100
            }
        }

        HoverHandler {
            id: mouse
        }
        

        Row {
            id: superWorkspaceRow
            anchors.centerIn:parent
            Repeater {
                model: superworkspaces
                TextWidget {
                    required property real index
                    required property var modelData

                    id: superTextWidget
                    inhalt: modelData.name

                    function click() {
                        activesuperworkspace = index
                    }

                    visible: index == activesuperworkspace ? true : mouse.hovered
                    Behavior on visible {
                        NumberAnimation {
                            duration: 100
                        }
                    }

                    Behavior on visible {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        implicitWidth:  workspaceRow.width
        height:         Themes.barheight
        color: "transparent"
        HoverHandler {
            id: workspaceRowMouse 
        }
        Row {
            id: workspaceRow
            anchors.centerIn:parent
        Repeater {
            model: superworkspaces[activesuperworkspace].workspaces
            ObjectWidget {
                id: w
                required property var modelData



                width:          hovered ? implicitWidth + 10 : implicitWidth
                required property int index
                property var ws:        Hyprland.workspaces.values.find(ws => ws.id === index + 1)

                property bool isaworkspace: windows().length !=0
                visible:      workspaceRowMouse.hovered ? true : (isaworkspace ? true : index == 0)

                Behavior on width {
                    NumberAnimation {
                        duration: 100
                    }
                }

                property bool isActive: Hyprland.focusedWorkspace.id === modelData


                function windows() {
                    Hyprland.refreshWorkspaces()
                    return Hyprland.toplevels.values.filter(w => w.workspace?.id === modelData)
                }

                function click() {
                    switchtows.running = true
                    console.log(windows().title)
                }

                Process {
                    id: switchtows
                    running: false
                    command: ["hyprctl","eval","hl.dispatch(hl.dsp.focus({ workspace =",modelData," }))"]
                }

                Row {
                    anchors.centerIn: parent
                    Text {
                        id: lol
                        text: modelData
                        color: w.isActive ? Themes.textcolor : Themes.workspaceinactivecolor
                        font.family: Themes.font[Themes.theme_number]
                        font.pointSize: 10
                        y:parent.height/2-lol.height/2
                    }
                    Repeater {
                        model: w.windows()
                        Text {
                            required property var modelData
                            property string appClass: modelData.title


                            function iconFor(title) {
                                const t = title.toLowerCase();
                                if (t.includes("~"))
                                    return Themes.kitty_icon[Themes.theme_number];
                                if (t.includes("dolphin"))
                                    return Themes.filemanager_icon[Themes.theme_number];
                                if (t.includes("firefox"))
                                    return Themes.firefox_icon[Themes.theme_number];
                                if (t.includes("nvim"))
                                    return Themes.vim_icon[Themes.theme_number];
                                if (t.includes("discord"))
                                    return Themes.discord_icon[Themes.theme_number];
                                if (t.includes("spotify"))
                                    return Themes.spotify_icon[Themes.theme_number];
                                if (t.includes("steam"))
                                    return Themes.steam_icon[Themes.theme_number];

                                if (t.includes(".pdf"))
                                    if (t.includes("zathura"))
                                        return "󰬇";
                                    else
                                        return "";

                                if (t.includes("qs")) 
                                    return ("󰫾");
                                return "";
                            }

                        
                            function colorFor(title) {
                                const t = title.toLowerCase();
                                if (t.includes("~"))
                                    return "lightblue";
                                if (t.includes("dolphin"))
                                    return "white";
                                if (t.includes("firefox"))
                                    return "orange";
                                if (t.includes("nvim"))
                                    return "lightblue";
                                if (t.includes("discord"))
                                    return "white";
                                if (t.includes("spotify"))
                                    return "lightgreen";
                                if (t.includes("steam"))
                                    return "lightblue";
                                if (t.includes(".pdf"))
                                    if (t.includes("zathura"))
                                        return "white";
                                    else
                                        return "red";

                                if (t.includes("qs")) 
                                    return ("lightgreen")

                                return "white";
                            }


                            text: iconFor(appClass)
                            color: w.isActive ? colorFor(appClass) : Themes.workspaceinactivecolor
                            font.pointSize: 10
                        }
                    }
                }
            }
        }
    }
}
}
