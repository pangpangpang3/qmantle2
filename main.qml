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

        Image {
            id: wallpaperleft
            source: "12030001.jpg"
            anchors.top: wallpaper.top
            anchors.bottom: wallpaper.bottom
            x: -wallpaper.width
            width: wallpaper.width
            property var anim: wallpaperLeftAnim

            NumberAnimation {
                id: wallpaperLeftAnim
                target: wallpaperleft
                properties: "x"
                from: wallpaperleft.x
                easing.type: Easing.OutExpo
                duration: 400
            }
        }

        Image {
            id: wallpaper
            source: "wallpaper.jpg"
            x: 0
            y: 0
            width: parent.width
            height: parent.height
            property var anim: wallpaperAnim

            NumberAnimation {
                id: wallpaperAnim
                target: wallpaper
                properties: "x"
                from: wallpaper.x
                easing.type: Easing.OutExpo
                duration: 400
            }
        }

        Image {
            id: wallpaperright
            source: "12050006.jpg"
            anchors.top: wallpaper.top
            anchors.bottom: wallpaper.bottom
            x: wallpaper.width
            width: wallpaper.width
            property var anim: wallpaperRightAnim

            NumberAnimation {
                id: wallpaperRightAnim
                target: wallpaperright
                properties: "x"
                from: wallpaperright.x
                easing.type: Easing.OutExpo
                duration: 400
            }
        }


        Image {
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                wallpaperRightAnim.stop()
                wallpaperAnim.stop()
                wallpaperLeftAnim.stop()
                wallpaperContainer.pressX = mouse.x
            }

            onPositionChanged: {
                var delta = wallpaperContainer.pressX - mouse.x;
                wallpaperleft.x = wallpaperleft.x - delta
                wallpaperright.x = wallpaperright.x - delta
                wallpaper.x = wallpaper.x - delta
                wallpaperContainer.pressX = mouse.x
            }

            function visibleOnScreen(wallpaper) {
                console.log("x " + wallpaper.x + " width " + wallpaper.width)
                if (wallpaper.x > 0 && wallpaper.x < wallpaper.width)
                    return wallpaper.width - wallpaper.x
                if (wallpaper.x > wallpaper.width)
                    return 0
                if (wallpaper.x < -wallpaper.width)
                    return 0
                return Math.abs(wallpaper.x + wallpaper.width)
            }

            // TODO: this doesn't quite do it, bounceback on the animation
            // effect means that we see a bit of white edge.. not sure how we
            // can wrap that around better, perhaps anchoring.. but it's not
            // straightforward to me at least
            //
            // TODO: there's a fun bug here (well, two of them).. when clicking
            // and instantly releasing (i.e. no drag), it seems to rotate
            // images, which wouldn't be so bad,  but.. double clicking seems to
            // rotate them in such a way that the animation is visible, which
            // looks awful
            function setXPosition(wallpaper, x) {
                if (visibleOnScreen(wallpaper)) {
                    wallpaper.anim.to = x
                    wallpaper.anim.start()
                } else {
                    wallpaper.x = x
                }
            }

            onReleased: {
                var leftDelta = visibleOnScreen(wallpaperleft)
                console.log("left " + leftDelta)
                var centerDelta = visibleOnScreen(wallpaper)
                console.log("center " + centerDelta)
                var rightDelta = visibleOnScreen(wallpaperright)
                console.log("right " + rightDelta)

                var leftWins = leftDelta > centerDelta && leftDelta > rightDelta
                var centerWins = centerDelta > rightDelta && centerDelta > leftDelta
                var rightWins = rightDelta > centerDelta && rightDelta > leftDelta

                if (centerWins) {
                    setXPosition(wallpaperright, wallpaper.width)
                    setXPosition(wallpaper, 0)
                    setXPosition(wallpaperleft, -wallpaper.width)
                } else if (leftWins) {
                    setXPosition(wallpaperright, -wallpaper.width)
                    setXPosition(wallpaper, wallpaper.width)
                    setXPosition(wallpaperleft, 0)
                } else if (rightWins) {
                    setXPosition(wallpaperright, 0)
                    setXPosition(wallpaper, -wallpaper.width)
                    setXPosition(wallpaperleft, wallpaper.width)
                }
            }
        }
    }

    TitleBar {
    }

    Launcher {
        id: launcher
    }
}
