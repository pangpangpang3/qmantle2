import QtQuick 2.0
import QtGraphicalEffects 1.0

import "constants.js" as Constants

// for testing homeScreen rotation animations
//Item {
//    height: 1050
//    width: 1680

//    x: 400

Item {
    id: homeScreen;
    width: Constants.screen.width
    height: Constants.screen.height
    clip: true

    property int orientation: Constants.landscape
    property var launcher
    property var switcher

    // hack: we can't reset rotation to Constants.landscape, because the
    // transition will go the wrong way. this will have the same effect, but not
    // look shit.
    onRotationChanged: {
        if (rotation == 360) {
            rotationAnim.enabled = false
            rotation = Constants.landscape
            rotationAnim.enabled = true
        }
    }

    Item {
        id: blurrable
        anchors.fill: parent

        Wallpaper {
        }

        TitleBar {
            id: titleBar

            onClicked: {
                // TODO: async loading
                if (!homeScreen.launcher) {
                    var component = Qt.createComponent("Launcher.qml");
                    if (component.status != Component.Ready) {
                        console.log("FAILED LOADING COMPONENT")
                        return
                    }

                    homeScreen.launcher = component.createObject(homeScreen)
                    homeScreen.launcher.showing.connect(function() {
                        blur.radius = 32
                    });
                    homeScreen.launcher.hiding.connect(function() {
                        blur.radius = 0
                    });
                }

                homeScreen.launcher.show();
            }

            DebugControl {
                anchors.right: rotateDebug.left
                text: "FPS"
                onClicked: {
                    fpsMonitor.toggle()
                }
            }

            DebugControl {
                id: rotateDebug
                anchors.right: switcherRect.left
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
                id: switcherRect
                anchors.right: titleBar.right
                text: "Open Switcher"

                onClicked: {
                    // TODO: async loading
                    if (!homeScreen.switcher) {
                        var component = Qt.createComponent("Switcher.qml");
                        if (component.status != Component.Ready) {
                            console.log("FAILED LOADING COMPONENT")
                            return
                        }

                        homeScreen.switcher = component.createObject(homeScreen)
                    }

                    homeScreen.switcher.showing.connect(function() {
                        blur.radius = 32
                    });
                    homeScreen.switcher.hiding.connect(function() {
                        blur.radius = 0
                    });
                    homeScreen.switcher.show();
                }
            }
        }
    }

    FastBlur {
        id: blur
        anchors.fill: parent
        source: blurrable

        Behavior on radius {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 500
            }
        }
    }

    Behavior on width {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }

    Behavior on height {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }

    Behavior on rotation {
        id: rotationAnim
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }


    FPSMonitor {
        id: fpsMonitor
    }
}

//}
