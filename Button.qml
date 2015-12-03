import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    property alias radius: button.radius
    property alias color: button.color
    property alias bold: text.font.bold
    property alias pixelSize: text.font.pixelSize
    property alias text: text.text
    property alias textColor: text.color
    property alias action : mouseArea
    property real zoom : 1.1
    property bool responsive : false
    property int elevation : 3
    height:parent.height/10; width:parent.width/8
    DropShadow {
        id:shadow
        anchors.fill: button
        horizontalOffset: 0
        verticalOffset: elevation
        radius: 3*elevation
        samples: 32
        color: "#80000000"
        source: button
        transparentBorder: true
        scale: mouseArea.containsMouse ? zoom : 1
        Behavior on scale { NumberAnimation { duration: 100 } }
    }

    Rectangle {
        id:button
        anchors.fill: parent
        scale: mouseArea.containsMouse ? zoom : 1
        Behavior on scale { NumberAnimation { duration: 100 } }
        Text {
            id:text; text:"Button"
            anchors.centerIn: parent
            color:"#333"; font { family:"Helvetica"; pixelSize: button.height/4 }
        }
        MouseArea { id:mouseArea; anchors.fill: parent; hoverEnabled: responsive }
    }
}

