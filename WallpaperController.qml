import QtQuick 2.0

import "widgets"

Item {
    id: wallpaperContainer
    anchors.fill: parent
    property var pressX
    property var leftMost: one
    property var center: two
    property var rightMost: three
    onWidthChanged: leftMost.setPosition(-wallpaperContainer.width)

    MouseArea {
        anchors.fill: parent

        onPressed: {
            wallpaperContainer.pressX = mouseX
        }

        function findLowest(objArr) {
            var tmp = 100000 // 100k pixels is enough for anyone
            var lowest = 0;

            for (var i = 0; i < objArr.length; ++i) {
                if (objArr[i].x < tmp) {
                    tmp = objArr[i].x
                    lowest = i
                }
            }

            var obj = objArr[lowest]
            objArr.splice(lowest, 1)
            return obj
        }

        function updatePositions() {
            var arr = [ one, two, three ]

            leftMost = findLowest(arr);
            center = findLowest(arr);
            rightMost = findLowest(arr);

            leftMost.anchors.left = undefined
            leftMost.anchors.right = undefined
            center.anchors.left = leftMost.right
            center.anchors.right = undefined
            rightMost.anchors.left = center.right
            rightMost.anchors.right = undefined
        }

        function swapLeft() {
            // swap leftmost to right
            console.log("Swapping leftmost right")
            leftMost.anchors.left = undefined
            leftMost.anchors.right = undefined
            center.anchors.left = undefined
            center.anchors.right = undefined
            leftMost.setPosition(rightMost.x + wallpaperContainer.width * 2)
            updatePositions()
        }

        function swapRight() {
            // we need to swap rightmost to left
            console.log("Swapping rightmost left")
            rightMost.anchors.left = undefined
            rightMost.anchors.right = undefined
            rightMost.setPosition(leftMost.x - wallpaperContainer.width)
            updatePositions()
        }

        onPositionChanged: {
            leftMost.setPosition(leftMost.x - (wallpaperContainer.pressX - mouseX))
            wallpaperContainer.pressX = mouseX

            if (leftMost.x >= 0) {
                swapRight()
            } else if (rightMost.x + rightMost.width <= wallpaperContainer.width) {
                swapLeft()
            }
        }

        onReleased: {
            // decide whether we need to adjust a snap in a different direction
            if (center.x >= wallpaperContainer.width / 3) {
                swapRight()
            } else if (center.x < -(wallpaperContainer.width / 3)) {
                swapLeft()
            }
            leftMost.x = -wallpaperContainer.width
        }
    }

    Wallpaper {
        id: one
        source: "assets/wallpapers/12030001.jpg"

        initialX: -wallpaperContainer.width
    }

    Wallpaper {
        id: two
        source: "assets/wallpapers/wallpaper.jpg"

        anchors.left: one.right

        // we *must* load before rendering, as we're the
        // displayed wallpaper. to not affect future load time, we reset this
        // once we're loaded.
        asynchronous: false

        Component.onCompleted: asynchronous = true

        widgets: [
            PhotoWidget {
                source: "assets/wallpapers/wallpaper.jpg"
            },
            ClockWidget {
            },
            PhotoWidget {
                source: "assets/wallpapers/FrancesOneMonth.jpg"
            },
            SketchWidget {
            },
            PhotoWidget {
                source: "assets/wallpapers/FoxyOneMonth.jpg"
            }
        ]
    }

    Wallpaper {
        id: three
        source: "assets/wallpapers/12050006.jpg"

        anchors.left: two.right
    }
}

