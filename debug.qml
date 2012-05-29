import QtQuick 2.0

import "constants.js" as Constants

// for testing homeScreen rotation animations
Item {
    property int maxWidth: homeScreen.width + 400
    property int maxHeight: homeScreen.height + 400

    Connections {
        target: homeScreen
        onWidthChanged: {
            if (homeScreen.width > maxWidth)
                maxWidth = homeScreen.width
        }

        onHeightChanged: {
            if (homeScreen.height > maxHeight)
                maxHeight = homeScreen.height
        }
    }

    height: maxHeight
    width: maxWidth

    Item {
        x: 400

        HomeScreen {
            id: homeScreen
        }
    }

    DebugControl {
        id: rotateControl
        anchors.left: parent.left
        text: "Rotate"

        onClicked: {
            if (homeScreen.rotation == Constants.landscape) {
                console.log('Rotating screen to portrait')
                homeScreen.orientation = Constants.portrait
                var t = homeScreen.height
                homeScreen.height = homeScreen.width
                homeScreen.width = t
                homeScreen.rotation = Constants.portrait
            } else if (homeScreen.rotation == Constants.portrait) {
                console.log('Rotating screen to reverseLandscape')
                homeScreen.orientation = Constants.landscape
                var t = homeScreen.height
                homeScreen.height = homeScreen.width
                homeScreen.width = t
                homeScreen.rotation = Constants.reverseLandscape
            } else if (homeScreen.rotation == Constants.reverseLandscape) {
                console.log('Rotating screen to reversePortrait')
                homeScreen.orientation = Constants.portrait
                var t = homeScreen.height
                homeScreen.height = homeScreen.width
                homeScreen.width = t
                homeScreen.rotation = Constants.reversePortrait
            } else if (homeScreen.rotation == Constants.reversePortrait) {
                console.log('Rotating screen to landscape')
                homeScreen.orientation = Constants.landscape
                var t = homeScreen.height
                homeScreen.height = homeScreen.width
                homeScreen.width = t
                homeScreen.rotation = 360 // Constants.landscape, see onRotationChanged hack
            }
        }
    }

    DebugControl {
        anchors.left: rotateControl.right
        text: "FPS"

        onClicked: {
            fpsMonitor.toggle()
        }
    }

    FPSMonitor {
        id: fpsMonitor
        anchors.left: parent.left
        anchors.top: rotateControl.bottom
    }
}

