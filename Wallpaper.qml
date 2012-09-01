import QtQuick 1.1

import "constants.js" as Constants

Image {
    id: wallpaper
    property variant behavior: wallpaperBehavior
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    sourceSize.width: Constants.screen.width
    sourceSize.height: Constants.screen.height
    width: parent.width
    property int initialX
    asynchronous: true
    fillMode: Image.PreserveAspectCrop
    property alias widgets: widgetLayout.children

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

    // widgets
    WidgetLayout {
        id: widgetLayout
        anchors.fill: parent
        anchors.bottomMargin: homeScreen.titleBar.height
    }
}

