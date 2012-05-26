import QtQuick 2.0

import "constants.js" as Constants

Image {
    id: wallpaper
    property var behavior: wallpaperBehavior
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    sourceSize.width: Constants.screen.width
    sourceSize.height: Constants.screen.height
    width: parent.width
    property int initialX
    asynchronous: true
    fillMode: Image.PreserveAspectCrop

    onInitialXChanged: setPosition(initialX)

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

