import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    property alias radius: button.radius
    property alias color: button.color
    property alias image: image
    property alias source: image.source
    property alias action : mouseArea
    property real zoom : 1.1
    property bool responsive : false
    property int elevation : 3
    property alias colorize: colorOverlay.visible
    property alias imageColor: colorOverlay.color
    property bool lotOfClicks : false
    height:parent.height/10; width:parent.width/8
    Timer {
        id: timer
        interval: lotOfClicks?0:400
        running: false
        repeat: false
        triggeredOnStart: false
        onTriggered: mouseArea.visible = true
    }
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
        Image {
            id:image
            height:parent.height*0.7; width: parent.width*0.7
            anchors.centerIn: parent;
            sourceSize.height: parent.height; sourceSize.width: parent.width
        }
        ColorOverlay {
            id:colorOverlay
            visible: false
            anchors.fill: image
            source: image
            color: "#3b3b3b"
        }
        MouseArea {
            id:mouseArea; anchors.fill: parent; hoverEnabled: responsive
            onClicked: {
                mouseArea.visible = false
                timer.start()
            }
        }
    }
}

