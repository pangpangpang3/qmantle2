import QtQuick 2.0

import "constants.js" as Constants

Item {
    id: homeScreen;
    width: 960;
    height: 600;

    function toggleModeChange() {
        launcher.show();
    }

    Item {
        id: wallpaperContainer
        anchors.fill: parent
        property var pressX
        property var pressY

        Image {
            id: wallpaper
            source: "wallpaper.jpg"
            x: 0
            y: 0
            width: parent.width
            height: parent.height
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                wallpaperContainer.pressX = mouse.x
            }

            onPositionChanged: {
                wallpaper.x = wallpaper.x - (wallpaperContainer.pressX - mouse.x)
                wallpaperContainer.pressX = mouse.x
            }

            onReleased: {
                wallpaper.x = 0
            }
        }
    }

    TitleBar {
    }

    Launcher {
        id: launcher
    }
}
