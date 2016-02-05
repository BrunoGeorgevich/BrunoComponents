import QtQuick 2.5
import "qrc:/components/functions.js" as JS

Item {
    id:root
    signal toggled()
    function getStatus() { return checked }
    property alias text : label.text
    property alias pixelSize : label.font.pixelSize
    property alias textColor: label.color
    property var color : "#242424"
    property var checked : false
    height: JS.hpercent(5,parent); width: JS.wpercent(15,parent)
    Row {
        id:row
        anchors { fill: parent; margins: JS.hpercent(3,parent) }
        spacing: JS.wpercent(10,this)
        Rectangle {
            id:circle
            function toggle() { checked = (checked ? false : true); toggled(); }
            state: checked? "toggled" : "untoggled"
            anchors.verticalCenter: parent.verticalCenter
            height: JS.hpercent(90,parent); width: height
            radius: width/2; color:root.color
            border { width:JS.hpercent(5,parent); color: root.color  }
            states: [
                State {
                    name: "toggled"
                    PropertyChanges { target: circle; color:root.color }
                },
                State {
                    name: "untoggled"
                    PropertyChanges { target: circle; color:"transparent" }
                }
            ]
            Behavior on color { ColorAnimation { duration: 200 } }
            MouseArea {
                anchors.fill: parent
                onClicked: circle.toggle()
            }
        }
        Item {
            height: JS.hpercent(100,parent); width: JS.wpercent(100,parent)
            Text {
                id:label
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                font { pixelSize: JS.hpercent(100,parent); weight: Font.Light }
                text:"Label"
            }
        }
    }
}
