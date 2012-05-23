import QtQuick 2.0

Image {
    anchors.top: homeScreen.top
    anchors.left: homeScreen.left
    anchors.right: homeScreen.right
    source: "images/wmTitleBar.png";
    fillMode: Image.TileHorizontally

    Image {
        id: launcherUnpressed
        anchors.left: parent.left
        anchors.top: parent.top
        source: "images/wmTaskLauncherIcon.png"
        opacity: 1
    }

    Image {
        id: launcherPressed
        anchors.left: parent.left
        anchors.top: parent.top
        source: "images/wmTaskLauncherIconPressed.png"
        opacity: 0
    }

    Text {
        anchors.verticalCenter: launcherUnpressed.verticalCenter
        anchors.left: launcherUnpressed.right

        text: Qt.formatTime(new Date) // XXX: is this efficient? also, TODO, don't update all the time and switch off when screen off
        color: "white"
        font.pixelSize: 20
    }

    MouseArea {
        id: mouseArea
        anchors.fill: launcherUnpressed

        onClicked: {
            homeScreen.toggleModeChange();
        }
    }

    states: [
        State {
            name: "pressed"
            when: mouseArea.pressed
            PropertyChanges {
                target: launcherUnpressed
                opacity: 0
            }

            PropertyChanges {
                target: launcherPressed
                opacity: 1
            }
        },

        State {
            name: "unpressed"
            when: !mouseArea.pressed
            PropertyChanges {
                target: launcherUnpressed
                opacity: 1
            }

            PropertyChanges {
                target: launcherPressed
                opacity: 0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "opacity"
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}

