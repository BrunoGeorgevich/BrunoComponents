import QtQuick 2.5
import QtQuick.Controls 1.4

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
    }
    Rectangle {
        id:_bottomBar
        anchors.bottom: parent.bottom
        width: JS.wpercent(100,parent)
        height: bottomBarVisible ? JS.hpercent(bottomBarHeightPercent,parent) : 0
        color:"Black"
    }
}

