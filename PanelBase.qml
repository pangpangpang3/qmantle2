import QtQuick 2.0

Item {
    id: panelBase
    anchors.fill: parent
    opacity: 0

    signal showing
    signal hiding

    Rectangle {
        id: wallpaper
        color: "black"
        opacity: 0.8
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: hide()
    }

    function show() {
        // TODO: would be nice to have this set by a binding somehow
        opacity = 1
        panelBase.showing()
    }

    function hide() {
        opacity = 0
        panelBase.hiding()
    }

    Behavior on opacity {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
}

