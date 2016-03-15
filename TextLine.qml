import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    property var selectColor : "#009688"
    property var normalColor : "#2196F3"
    property var errorColor : "#F32121"
    property alias textColor : textEdit.color
    property alias placeholder : label.text
    property alias text : textEdit.text
    property var edited : false
    property var password : false
    signal verification()
    function getText() { return textEdit.text }
    function getTextLength() { return textEdit.text.length }
    function error() { normalColor = errorColor }
    function isEmpty() { return textEdit.text.length == 0 ? true:false }
    Item {
        id:rect
        anchors.fill: parent
        Rectangle {
            id:line
            color:edited?(textEdit.focus ? selectColor : normalColor):"#9E9E9E"
            anchors { fill: parent; topMargin: parent.height*0.9 }
            Behavior on color { ColorAnimation { duration:200 } }
        }
        TextInput {
            id:textEdit
            anchors.fill: parent
            color: "#555"; clip:true
            echoMode: password ? TextInput.Password : TextInput.Normal
            font { pixelSize: parent.height*0.6; family:"Helvetica" }
            verticalAlignment: TextEdit.AlignVCenter
            onFocusChanged: {
                verification()
                edited=true
            }
        }
    }
    Text {
        id:label
        function stateSwitcher(){
            if(textEdit.text.length > 0) return "off"
            return textEdit.focus ? "off" : "on"
        }
        text:"Label"; state: stateSwitcher();
        font { pixelSize: parent.height*0.6;family: "Helvetica" }
        color:edited?(textEdit.focus ? selectColor : normalColor ):"#9E9E9E"
        Behavior on color { ColorAnimation { duration:200 } }
        states: [
            State {
                name: "on"
                AnchorChanges {
                    target: label
                    anchors.bottom:undefined
                    anchors.verticalCenter: rect.verticalCenter
                }
            },
            State {
                name: "off"
                AnchorChanges {
                    target: label
                    anchors.bottom:rect.top
                    anchors.verticalCenter: undefined
                }
            }
        ]
        transitions: Transition { from: "*"; to: "*"; AnchorAnimation { duration: 200 } }
    }
}

