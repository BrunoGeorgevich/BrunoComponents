import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    property alias radius: button.radius
    property alias color: button.color
    property alias bold: text.font.bold
    property alias font: text.font
    property alias pixelSize: text.font.pixelSize
    property alias text: text.text
    property alias textColor: text.color
    property alias action : mouseArea
    property real zoom : 1.1
    property bool responsive : false
    property bool allCaps : true
    property int elevation : 3
    property bool wave : false
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
        anchors.fill: parent; clip:true
        scale: mouseArea.containsMouse ? zoom : 1
        Behavior on scale { NumberAnimation { duration: 100 } }
        Item {
            anchors.fill: parent; clip:true
            Rectangle {
                id:effect
                width:parent.width*2; height: width; radius:width/2; scale:0
                color:Qt.lighter(button.color,2.2)
            }
        }
        SequentialAnimation {
            id: waveEffect
            running: false; loops: 1
            ParallelAnimation {
                NumberAnimation { target:effect; property:"scale"; to:1; duration:400 }
                NumberAnimation { target:effect; property:"opacity"; to:0; duration:400 }
            }
            ScriptAction {
                script: {
                    effect.scale=0;effect.opacity=1
                }
            }
        }
        Text {
            id:text; text:"Button"
            anchors.centerIn: parent
            color:"#535353";
            font {
                weight: Font.Medium;
                pixelSize: button.height/4;
                capitalization: allCaps ? Font.AllUppercase : Font.Capitalize;
            }
        }
        MouseArea {
            id:mouseArea; anchors.fill: parent; hoverEnabled: responsive
            onClicked: {
                if(wave) {
                    effect.x = mouse.x - effect.width/2; effect.y = mouse.y - effect.height/2
                    waveEffect.start()
                }
            }
        }
    }
}

