import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    id:root
    property var opened : false
    property alias sideBarColor: sideBar.color
    property alias sideBarWidth: sideBar.width
    property alias sideBarHeight: sideBar.height
    property alias sideBarContent: sideBar.children
    function close() { opened = false }
    function open() { opened = true }
    height:parent.height; width:parent.width
    state: root.opened ? "show":"hide"

    Rectangle {
        id:backRect
        anchors { top:parent.top; bottom:parent.bottom; left:sideBar.right; right:parent.right }
        color:"#000"; opacity:0
        MouseArea {
            anchors.fill: parent
            onClicked: root.close()
        }
    }

    DropShadow {
        anchors.fill: sideBar
        horizontalOffset: parent.width/300
        verticalOffset: parent.height/300
        radius: parent.width/100
        samples: 32
        color: "#80000000"
        source: sideBar
        transparentBorder: true
    }

    Rectangle {
        id:sideBar
        color:"#AAA"
        width:parent.width/3
        height: parent.height
    }

    states: [
        State {
            name: "hide"
            AnchorChanges {
                target: root
                anchors.right: root.parent.left
            }
            PropertyChanges {
                target: root
                opened : false
            }
        },
        State {
            name: "show"
            AnchorChanges {
                target: root
                anchors.right: root.parent.right
            }
            PropertyChanges {
                target: root
                opened : true
            }
        }
    ]
    transitions: [
        Transition {
            from: "hide"
            to: "show"
            SequentialAnimation {
                AnchorAnimation { duration: 300 }
                NumberAnimation { target: backRect; property: "opacity"; to:0.15; duration:300 }
            }
        },
        Transition {
            from: "show"
            to: "hide"
            SequentialAnimation {
                NumberAnimation { target: backRect; property: "opacity"; to:0; duration:300 }
                AnchorAnimation { duration: 400 }
            }
        }
    ]
}

