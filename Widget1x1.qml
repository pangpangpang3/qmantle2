import QtQuick 2.0

import "constants.js" as Constants

Item {
    width: homeScreen.orientation == Constants.landscape ? homeScreen.width / 6 : homeScreen.width / 3
    height: width

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
