import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Shapes 1.11
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import qs.widgets
import qs.themes

Repeater {
    id: root
    model: numbers

    required property bool vis
    
    property list<string> numbers: ["Null","eins","zwei","drei","vier","fünf","sechs","sieben","acht","neun","zehn","elf","zwölf","dreizehn","vierzehn","fünfzehn","sechzehn","siebzehn","achtzehn","neunzehn"]
    property list<string> colors: ["#F0FDF4","#DCFCE7","#B9F8CF",
    "#7BF1A8","#05DF72","#31C950","#2AA63E","#178236","#016630","#0D542B","#032E15","#51A2FF","#2B7FFF","#155DFC","#1447E6","#193CB8","#1C398E","#162456"]
    property real a: 500
    property real b: 80

    property real seitenlaenge: 100
    
    // let i be in (0,2 pi)
    //
    function pos_in_2pi(i): int {
            return (2*Math.PI)/model.length * i - Math.PI/2
    }
    function x_position(i): real {
        return a * Math.cos(i) + 635 
    }

    function y_position(i): real {
        return - b* Math.sin(i) + 200
    }

    function z_position(n): real {
        return Math.abs(Math.ceil(numbers.length/2)-n) 
    }

    function rectSize(z_pos): real {
        return seitenlaenge  + z_pos*20
    }

    property real counter: 0
    Keys.onPressed: (event)=> {
        if      (event.key == Qt.Key_Up) { 
            numbers = rotateModelRight(numbers)
            console.log("up")
        } 
        else if (event.key == Qt.Key_Down)  { 
            numbers = rotateModelLeft(numbers)
            console.log("down")
        } 
    }
    
    function incre(){ 
        if (counter < root.numbers.length -1) {
            counter++
        } else { 
            counter = 0 
        } console.log("inc")
    }
    function decre()                { if (counter > 0)                      { counter-- }                               else { counter = root.numbers.length - 1 } console.log("dec") }

    function start(k)               { if (counter < k)                      { return root.wps.length + counter - k }    else { return counter - k } }
    function end(k)                 { if (counter >= root.wps.length -k)    { return counter + k - root.wps.length }    else { return counter + k } }
    
    function rotateModelLeft(model): list<var> {
        model.unshift(model.pop());
        console.log("rotated left")
    }
    function rotateModelRight(model): list<var> {
        model.push(model.shift());
        console.log("rotated right")
    }

    Rectangle {
        id: rect 
        required property real index
        required property string modelData

        visible: vis

        width: rectSize(z_position(index+counter))
        height:rectSize(z_position(index+counter))

        x: x_position(pos_in_2pi(index+counter)) - width/2
        y: y_position(pos_in_2pi(index+counter))
        z: z_position(index)
        color: root.colors[index]

        Text {
            id: text
            color: "black"
            font.pixelSize: 20
            text: modelData + " " + rect.z
            anchors.centerIn: parent
        }
    }
}




    
