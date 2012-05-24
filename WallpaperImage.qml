import QtQuick 2.0

Image {
    id: wallpaper
    property var behavior: wallpaperBehavior
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    sourceSize.width: width
    sourceSize.height: height
    width: parent.width

    function setPosition(newX) {
        wallpaperBehavior.enabled = false;
        x = newX
        wallpaperBehavior.enabled = true
    }

    Behavior on x {
        id: wallpaperBehavior
        NumberAnimation {
            easing.type: Easing.OutExpo
            duration: 400
        }
    }
}

