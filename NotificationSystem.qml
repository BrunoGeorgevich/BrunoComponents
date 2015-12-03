import QtQuick 2.0

Item {
    id:notificationRoot

    property string notificationColor : "Black"
    property bool onTheTop : false
    property int timeInterval: 2000

    function notify(msg) {
        notificationRect.state = "show"
        notificationTxt.text = msg
        timer.restart()
    }

    function coloredNotify(msg, color) {
        notificationRect.state = "show"
        notificationTxt.text = msg
        notificationColor = color
        notificationRect.color = notificationColor
        timer.restart()
    }

    onOnTheTopChanged: notificationRect.y = (onTheTop)?-height:notificationRoot.height

    anchors.fill: parent

    Timer {
        id:timer

        onTriggered: {
            notificationRect.state = "hide"
        }

        interval: timeInterval
        repeat: false
    }

    Rectangle {
        id:notificationRect

        function show() {
            if(onTheTop) { y = notificationRoot.height*(0.08) }
            else { y = notificationRoot.height*(0.92) - height }
        }

        function hide() {
            if(onTheTop) { y = -height }
            else { y = notificationRoot.height }
        }

        scale:0
        width:parent.width*(0.4)
        height:parent.height*(0.05)

        y:(onTheTop)?-height:notificationRoot.height;

        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        radius: height/6
        color: notificationColor

        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }

        Behavior on y {
            id:behaviorOnY
            NumberAnimation {
                duration: 700
                easing.type:Easing.InOutQuad
            }
        }

        states: [
            State { name: "show" },
            State { name: "hide" }
        ]

        transitions: [
            Transition {
                to: "show"
                ScriptAction { script:notificationRect.show() }
                PropertyAnimation { target:notificationRect; property: "scale"; from:0; to:1; duration:400 }
            },
            Transition {
                to: "hide"
                ScriptAction { script:notificationRect.hide() }
                PropertyAnimation { target:notificationRect; property: "scale"; from:1; to:0; duration:400 }
            }
        ]

        Text {
            id:notificationTxt

            function fontSize() {
                if(text.length <= 10)
                    return height*0.7
                else if(text.length <= 20)
                    return height*0.5
                else
                    return height*0.4
            }

            onTextChanged: {
                notificationTxt.text = text.substring(0,50);
            }

            anchors.fill: parent

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            clip: true

            font.pixelSize: fontSize()
            color:"White"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: { notificationRect.color = Qt.lighter(notificationColor) ; timer.stop() }
            onExited: { notificationRect.color = notificationColor ; timer.start() }

            onClicked: { timer.stop(); notificationRect.state = "hide" }
        }
    }
}

