import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: homeScreen;
    width: 960
    height: 600

    property int orientation: 0
    property int landscape: 0
    property int portrait: 90

    property var launcher
    property var switcher

    Item {
        id: blurrable
        anchors.fill: parent

        Wallpaper {
        }

        TitleBar {
            id: titleBar

            onClicked: {
                // TODO: async loading
                if (!launcher) {
                    var component = Qt.createComponent("Launcher.qml");
                    if (component.status != Component.Ready) {
                        console.log("FAILED LOADING COMPONENT")
                        return
                    }

                    launcher = component.createObject(homeScreen)
                    launcher.showing.connect(function() {
                        blur.radius = 32
                    });
                    launcher.hiding.connect(function() {
                        blur.radius = 0
                    });
                }

                launcher.show();
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
                    if (homeScreen.orientation == homeScreen.landscape) {
                        console.log('Rotating screen to portrait')
                        homeScreen.orientation = homeScreen.portrait
                        var t = homeScreen.height
                        homeScreen.height = homeScreen.width
                        homeScreen.width = t
                    } else if (homeScreen.orientation == homeScreen.portrait) {
                        console.log('Rotating screen to landscape')
                        homeScreen.orientation = homeScreen.landscape
                        var t = homeScreen.height
                        homeScreen.height = homeScreen.width
                        homeScreen.width = t
                    }
                }
            }

            DebugControl {
                id: switcherRect
                anchors.right: titleBar.right
                text: "Open Switcher"

                onClicked: {
                    // TODO: async loading
                    if (!switcher) {
                        var component = Qt.createComponent("Switcher.qml");
                        if (component.status != Component.Ready) {
                            console.log("FAILED LOADING COMPONENT")
                            return
                        }

                        switcher = component.createObject(homeScreen)
                    }

                    switcher.showing.connect(function() {
                        blur.radius = 32
                    });
                    switcher.hiding.connect(function() {
                        blur.radius = 0
                    });
                    switcher.show();
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

    FPSMonitor {
        id: fpsMonitor
    }
}
