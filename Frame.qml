import QtQuick 2.5
import Qt.labs.controls 1.0

import "functions.js" as JS

Item {
    property alias stack : _stackPages
    property alias content : _stackPages.initialItem
    property var topBarVisible : true
    property var bottomBarVisible : true
    property var topBarHeightPercent : 10
    property var bottomBarHeightPercent : 10
    property alias topBarColor : _topBar.color
    property alias bottomBarColor : _bottomBar.color
    property alias topBarContent : _topBar.children
    property alias bottomBarContent : _bottomBar.children
    property alias stackPushEnter : _stackPages.pushEnter
    property alias stackPushExit : _stackPages.pushExit
    property alias stackPopEnter : _stackPages.popEnter
    property alias stackPopExit : _stackPages.popExit
    anchors.fill: parent
    Rectangle {
        id:_topBar
        anchors.top: parent.top
        width: JS.wpercent(100,parent)
        height: topBarVisible ? JS.hpercent(topBarHeightPercent,parent) : 0
        color:"Black"
    }
    StackView {
        id:_stackPages
        anchors {
            left:parent.left; right: parent.right;
            top: _topBar.bottom; bottom: _bottomBar.top
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: width
                to:0
                duration: 100
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to:-width
                duration: 100
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: -width
                to:0
                duration: 100
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "x"
                from: 0
                to:width
                duration: 100
            }
        }
    }
    Rectangle {
        id:_bottomBar
        anchors.bottom: parent.bottom
        width: JS.wpercent(100,parent)
        height: bottomBarVisible ? JS.hpercent(bottomBarHeightPercent,parent) : 0
        color:"Black"
    }
}

