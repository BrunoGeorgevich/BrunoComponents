import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    property alias content : card.children
    property alias color : card.color
    property alias card : card
    height:parent.height/3; width: parent.width/3
    DropShadow {
        id:shadow
        anchors.fill: card
        horizontalOffset: parent.height/80
        verticalOffset: parent.height/60
        radius: parent.height/30
        samples: 32
        color: "#80000000"
        source: card
        transparentBorder: true
    }
    Rectangle {
        id:card
        anchors.fill: parent
        radius: this.width*0.01
    }
}

