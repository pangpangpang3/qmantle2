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
        id: currentTime
        anchors.verticalCenter: launcherUnpressed.verticalCenter
        anchors.left: launcherUnpressed.right

        text: Qt.formatTime(new Date) // XXX: is this efficient?
        color: "white"
        font.pixelSize: 20
    }

    Timer {
        repeat: true
        running: true
        interval: 63000 // not exact timing, but doesn't matter that much, the less wakeups the better
        onTriggered: {
            currentTime.text = Qt.formatTime(new Date) // TODO: don't update when screen is off
        }
    }


    MouseArea {
        id: mouseArea
        anchors.fill: launcherUnpressed

        onClicked: {
            homeScreen.toggleModeChange();
        }
    }
}

