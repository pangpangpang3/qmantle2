import QtQuick 2.0

Item {
    id: panelBase
    anchors.fill: parent
    opacity: 0

    Rectangle {
        id: wallpaper
        color: "black"
        opacity: 0.5
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: hide()
    }

    function show() {
        // TODO: would be nice to have this set by a binding somehow
        homeScreen.blurRadius = 32
        opacity = 1
    }

    function hide() {
        homeScreen.blurRadius = 0
        opacity = 0
    }

    Behavior on opacity {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
}

