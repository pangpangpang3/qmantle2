import QtQuick 2.0

Image {
    anchors.left: parent.left
    anchors.top: parent.top
    Behavior on opacity {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}

