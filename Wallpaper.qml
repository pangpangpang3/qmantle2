import QtQuick 2.0

Item {
    id: wallpaperContainer
    anchors.fill: parent
    property var pressX

    WallpaperImage {
        id: wallpaperleft
        source: "12030001.jpg"
        x: -wallpaper.width
        width: wallpaper.width
    }

    WallpaperImage {
        id: wallpaper
        source: "wallpaper.jpg"
        x: 0
        width: parent.width
    }

    WallpaperImage {
        id: wallpaperright
        source: "12050006.jpg"
        x: wallpaper.width
        width: wallpaper.width
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            wallpaperContainer.pressX = mouse.x
        }

        onPositionChanged: {
            var delta = wallpaperContainer.pressX - mouse.x;
            wallpaperleft.setPosition(wallpaperleft.x - delta)
            wallpaperright.setPosition(wallpaperright.x - delta)
            wallpaper.setPosition(wallpaper.x - delta)
            wallpaperContainer.pressX = mouse.x
        }

        function visibleOnScreen(wallpaper) {
            //console.log("x " + wallpaper.x + " width " + wallpaper.width)
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
                wallpaper.x = x
            } else {
                wallpaper.setPosition(x)
            }
        }

        onReleased: {
            var leftDelta = visibleOnScreen(wallpaperleft)
            //console.log("left " + leftDelta)
            var centerDelta = visibleOnScreen(wallpaper)
            //console.log("center " + centerDelta)
            var rightDelta = visibleOnScreen(wallpaperright)
            //console.log("right " + rightDelta)

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

