import QtQuick 2.0

import "constants.js" as Constants

// for testing homeScreen rotation animations
Item {
    height: 1050
    width: 1680

    Item {
        x: 400

        HomeScreen {
            id: homeScreen
        }
    }

    Rectangle {
        id: rotateControl
        anchors.left: parent.left
        anchors.top: parent.top
        color: "red"
        width: rtext.paintedWidth * 3
        height: rtext.paintedHeight * 5

        Text {
            id: rtext
            anchors.centerIn: parent
            text: "Rotate"
        }

        MouseArea {
            anchors.fill: parent
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
    }

    Rectangle {
        anchors.left: rotateControl.right
        anchors.leftMargin: 10
        color: "red"
        width: ftext.paintedWidth * 3
        height: ftext.paintedHeight * 5

        Text {
            id: ftext
            anchors.centerIn: parent
            text: "FPS"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fpsMonitor.toggle()
            }
        }
    }

    FPSMonitor {
        id: fpsMonitor
    }
}

