import Quickshell
import Quickshell.Io
import QtQuick

pragma Singleton

Singleton {
    id: root
    // Pipeline:
    Component.onCompleted: { // on reloading qs (building this singleton) or
        do_all()
        console.log("THEME: Component onCompleted")
        }
    onTheme_numberChanged: { // if changing the theme, execute do all() 
        do_all()
        console.log("THEME: Theme successfully changed")
    }   
    
    property var data: ({}) 
    function do_all() {
        jsonProcess.running = true // 1. saving json props in "data"
        delay_use_data.running = true // 2. with a little delay overwrite placeholder stats
        write_text_files.running = true // 3. with a second delay wrtie textfiles into hypr 
        reload_hyprland_timer.running = true // 4. the last delay reloads hyprland and lets it read new textfiles earlier written, thus altering the appearance
    }

    function toColor(r,g,b,a) {
        return Qt.rgba(r/255,g/255,b/255,a)
    }

    function to_rgba(obj) {
        return "rgba(" +
        data["colors"][obj]["r"][theme_number] + "," +
        data["colors"][obj]["g"][theme_number] + "," +
        data["colors"][obj]["b"][theme_number] + "," +
        data["colors"][obj]["a"][theme_number] + ")"
    }

    function zeit() {
        return 'cmd[update:1000] echo' + ' "<span>$(date +"%H:%M")</span>" '
    }

    function hyprlock_conf_test() {
        return "
        background {
            blur_size = 2
        }

        input-field {
            size = 430, 60
            font_size = 90
            outline_thickness = 2
        }"
    }

    Process {
        id: jsonProcess
        command: ["cat", "/home/malik/.config/quickshell/themes/Themes.json"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.data = JSON.parse(text)
                    console.log("STYLE: json loaded")
                } catch (e) {
                    console.log("STYLE: error loading json", e)
                }
            }
        }
    }

    Process {id: reload_hyprland;       command: ["hyprctl","reload"]}
    Process {id: hypr_radius;           command: ["sh", "-c", "printf '%s\\n' '" + radius + "' > '.config/hypr/config/radius.txt'"]}
    Process {id: hypr_bordercolor;      command: ["sh", "-c", "printf '%s\\n' '" + bordercolor + "' > '.config/hypr/config/bordercolor.txt'"]}
    Process {id: hypr_gap;              command: ["sh", "-c", "printf '%s\\n' '" + gap + "' > '.config/hypr/config/gap.txt'"]}
    Process {id: hypr_borderwidth;      command: ["sh", "-c", "printf '%s\\n' '" + borderwidth + "' > '.config/hypr/config/borderwidth.txt'"]}
    Process {id: hypr_widgetcolor;      command: ["sh", "-c", "printf '%s\\n' '" + widgetcolor + "' > '.config/hypr/config/widgetcolor.txt'"]}
    Process {id: hypr_textcolor;        command: ["sh", "-c", "printf '%s\\n' '" + textcolor + "' > '.config/hypr/config/textcolor.txt'"]}

    Process {id: write_hyprlockConfig;  command: [
        "sh", "-c",
        "cat > .config/hypr/hyprlock.conf <<'EOF'\n" +
        "background {\n" +
        "    path = screenshot\n" +
        "    blur_passes = 5\n" +
        "    blur_size = 2\n" +
        "}\n" +
        "\n" +
        "general {\n" +
        "    hide_cursor = true\n" +
        "    ignore_empty_input = true\n" +
        "}\n" +
        "input-field {\n" +
        "    fade_on_empty = false\n" +
        "    rounding =" + radius +"\n" +
        "    size = 400, 70\n" +
        "    dots_size = 0.1\n" +
        "    dots_spacing = 1\n" +
        "    dots_rounding =" + radius +"\n" +
        "    outer_color =rgba(" + data["colors"]["border"]["r"][theme_number] + "," + data["colors"]["border"]["g"][theme_number] + "," + data["colors"]["border"]["b"][theme_number] + "," + data["colors"]["border"]["a"][theme_number] + ")\n" +
        "    inner_color =rgba(" + data["colors"]["widget"]["r"][theme_number] + "," + data["colors"]["widget"]["g"][theme_number] + "," + data["colors"]["widget"]["b"][theme_number] + "," + data["colors"]["widget"]["a"][theme_number] + ")\n" +
        "    font_color =rgba(" + data["colors"]["text"]["r"][theme_number] + "," + data["colors"]["text"]["g"][theme_number] + "," + data["colors"]["text"]["b"][theme_number] + "," + data["colors"]["text"]["a"][theme_number] + ")\n" +
        "    font_family = Monocraft\n" +
        "}\n" +
        "\n" +
        "EOF"
        ]
    }





    Timer {id: delay_use_data;          interval: 250; repeat: false; running: false; onTriggered: { use_data() }}
    Timer {id: write_text_files;        interval: 500; repeat: false; running: false; onTriggered: {
            hypr_radius.running         = true
            hypr_bordercolor.running    = true
            hypr_gap.running            = true
            hypr_borderwidth.running    = true
            hypr_widgetcolor.running    = true
            hypr_textcolor.running      = true

            write_hyprlockConfig.running= true

            console.log("STYLE: text files for hyprland written successfully")
        }
    }
    Timer {id: reload_hyprland_timer;   interval: 750; repeat: false; running: false; onTriggered: {
            reload_hyprland.running = true
            console.log("STYLE: hyprland reloaded")
        }
    }

    function use_data() {
        workspaceinactivecolor= toColor(
            data["colors"]["workspaceinactive"]["r"][theme_number],
            data["colors"]["workspaceinactive"]["g"][theme_number],
            data["colors"]["workspaceinactive"]["b"][theme_number],
            data["colors"]["workspaceinactive"]["a"][theme_number]
        )
        gap=                    data["gap"][theme_number]
        borderwidth=            data["borderwidth"][theme_number]
        radius=                 data["radius"][theme_number]
        barheight=              data["barheight"][theme_number]
        barcolor=               toColor(
            data["colors"]["bar"]["r"][theme_number],
            data["colors"]["bar"]["g"][theme_number],
            data["colors"]["bar"]["b"][theme_number],
            data["colors"]["bar"]["a"][theme_number]
        )
        widgetcolor=            toColor(
            data["colors"]["widget"]["r"][theme_number],
            data["colors"]["widget"]["g"][theme_number],
            data["colors"]["widget"]["b"][theme_number],
            data["colors"]["widget"]["a"][theme_number]
        )
        bordercolor=            toColor(
            data["colors"]["border"]["r"][theme_number],
            data["colors"]["border"]["g"][theme_number],
            data["colors"]["border"]["b"][theme_number],
            data["colors"]["border"]["a"][theme_number]
        )
        hovercolor=             toColor(
            data["colors"]["hover"]["r"][theme_number],
            data["colors"]["hover"]["g"][theme_number],
            data["colors"]["hover"]["b"][theme_number],
            data["colors"]["hover"]["a"][theme_number]
        )
        textcolor=              toColor(
            data["colors"]["text"]["r"][theme_number],
            data["colors"]["text"]["g"][theme_number],
            data["colors"]["text"]["b"][theme_number],
            data["colors"]["text"]["a"][theme_number]
        )

    }
    
    property real theme_number:                 0

    property list<string> font: [
        "Monocraft",
        "cubic",
        "HeavyDataNerdFont-Regular",
        ]
    //placeholder to avoid errors
    property real gap:                      0
    property real borderwidth:              0
    property real radius:                   0
    property real barheight:                40
    property var  barcolor:                 "#000000"
    property var  widgetcolor:              "#000000"
    property var  bordercolor:              "#000000"
    property var  hovercolor:               "#000000"
    property var  textcolor:                "#000000"
    property var  workspaceinactivecolor:   "#000000" 

    //icons
    property list<string> kitty_icon: [
        "󰄛","󰄛","󰄛"
    ]

    property list<string> filemanager_icon: [
        "󱢴","󱢴","󰄛"
    ]

    property list<string> firefox_icon: [
        "󰈹","󰈹","󰄛"
    ]

    property list<string> obsidian_icon: [
        "󰮊","󰮊","󰄛"
    ]

    property list<string> vim_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> network_icon: [
        "󰘊","󰘊","󰘊","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> mute_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> unmute_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> x_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> wlogoutwidget_icon: [
        "󰍃","2","󰍃","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> hyprlock_icon: [
        "","v","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> shutdown_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> reboot_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> discord_icon: [
        "","","","󰀻","󰀻","󰀻","󰀻","󰀻","󰀻"
    ]

    property list<string> spotify_icon: [
        "󰓇","󰓇","󰄛"
    ]

    property list<string> steam_icon: [
        "󰓓","󰓓","󰄛"
    ]

    property list<string> bindmenu_icon: [
        "󰀻","󰛡","󰄛"
    ]

    //hard widths
    property list<real> wlogoutwidth: [
        20,20,20,20,20,20,20,20,20 
    ]


    //boolians

    property bool networkmenu_vis:              false

    property bool networkscan:                  false

    property bool cpuvis:                       false
    property bool ramvis:                       false
    property bool netvis:                       false
    property bool updatevis:                    false
}
