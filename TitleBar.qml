import QtQuick 1.1

Image {
    id: titleBar
    source: "assets/chrome/wmTitleBar.png";
    fillMode: Image.TileHorizontally

    signal clicked

    TitleIcon {
        id: launcherUnpressed
        source: "assets/chrome/wmTaskLauncherIcon.png"
        opacity: !mouseArea.pressed
    }

    TitleIcon {
        source: "assets/chrome/wmTaskLauncherIconPressed.png"
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

        onClicked: titleBar.clicked()
    }
}

