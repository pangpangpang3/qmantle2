import QtQuick 2.0

import "constants.js" as Constants

Item {
    width: {
        if (homeScreen.orientation == Constants.landscape)
           return homeScreen.width / 4
        else
           return homeScreen.width / 3
   }
    height: {
        if (homeScreen.orientation == Constants.landscape)
            return (homeScreen.height - homeScreen.titleBar.height) / 3
        else
            return (homeScreen.height - homeScreen.titleBar.height) / 4
    }

    Rectangle {
        anchors.fill: parent
        color: "red"
        opacity: 0.5
    }

    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "black"
        width: 1
    }
    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "red"
        width: 1
    }
/*
    Behavior on width {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 50
        }
    }

    Behavior on height {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 50
        }
    }*/
}
