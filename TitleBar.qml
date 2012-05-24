import QtQuick 2.0

Image {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    source: "images/wmTitleBar.png";
    fillMode: Image.TileHorizontally

    TitleIcon {
        id: launcherUnpressed
        source: "images/wmTaskLauncherIcon.png"
        opacity: !mouseArea.pressed
    }

    TitleIcon {
        source: "images/wmTaskLauncherIconPressed.png"
        opacity: mouseArea.pressed
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
}

