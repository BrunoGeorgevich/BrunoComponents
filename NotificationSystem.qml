import QtQuick 2.5
import QtQuick.Window 2.0

Item {
    id:notificationRoot
    property var notificationColor : "#333"
    property bool isOnTheTop : false
    property bool centralized : false
    property var defaultH: parent.height/10
    property var defaultW: parent.width/2
    property alias timeInterval: timer.interval
    function show() { notificationRoot.state = isOnTheTop?"showT":"showB" }
    function hide() { notificationRoot.state = isOnTheTop?"hideT":"hideB" }
    function notify(msg) { coloredNotify(msg,"#333") }
    function coloredNotify(msg, color) {
        show(); timer.restart()
        notificationColor = color
        notificationLabel.text = msg
        notificationRect.color = notificationColor
    }
    state:isOnTheTop?"hideT":"hideB"
    height:defaultH; width:defaultW
    anchors{
        margins:parent.height/50
        right:centralized?undefined:parent.right
        horizontalCenter: centralized?parent.horizontalCenter:undefined
    }

    Timer {
        id:timer
        interval: 2000; repeat: false
        onTriggered: notificationRoot.hide()
    }
    Rectangle {
        id:notificationRect
        anchors.fill:parent
        radius: height/6; color: notificationColor
        MouseArea {
            anchors.fill: parent; hoverEnabled: true
            onEntered: { notificationRect.color = Qt.lighter(notificationColor,1.2) ; timer.stop() }
            onExited: { notificationRect.color = notificationColor ; timer.start() }
            onClicked: { timer.stop(); notificationRoot.state = isOnTheTop?"hideT":"hideB" }
        }
    }
    Text {
        id:notificationLabel
        anchors.centerIn: parent
        height:parent.height*0.8; width:parent.width*0.9
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: height*0.5; fontSizeMode: Text.Fit
        text:"Oi"; color:Qt.lighter(notificationColor,3.5)
        onTextChanged:  {
            notificationRoot.height=defaultH
            notificationRoot.width=defaultW
            while(notificationRoot.height < notificationLabel.contentHeight) {
                notificationRoot.height *= 1.2
            }
        }
    }

    states: [
        State {
            name: "showT";
            AnchorChanges {
                target:notificationRoot
                anchors.top:parent.top
                anchors.bottom:undefined
            }
        },
        State {
            name: "hideT";
            AnchorChanges {
                target:notificationRoot
                anchors.bottom:parent.top
                anchors.top:undefined
            }
        },
        State {
            name: "showB";
            AnchorChanges {
                target:notificationRoot
                anchors.top:undefined
                anchors.bottom:parent.bottom
            }
        },
        State {
            name: "hideB";
            AnchorChanges {
                target:notificationRoot
                anchors.bottom:undefined
                anchors.top:parent.bottom
            }
        }
    ]
    transitions: [
        Transition { from:"hideT"; to: "showT"; AnchorAnimation { duration:400; easing.type: "OutBack"  } },
        Transition { from:"showT"; to: "hideT"; AnchorAnimation { duration:400; easing.type: "InBack" } },
        Transition { from:"hideB"; to: "showB"; AnchorAnimation { duration:400; easing.type: "OutBack"  } },
        Transition { from:"showB"; to: "hideB"; AnchorAnimation { duration:400; easing.type: "InBack" } }
    ]
}
