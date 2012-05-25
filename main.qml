import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: homeScreen;
    width: 960
    height: 600
    property alias blurRadius: blur.radius

    property int orientation: 0
    property int landscape: 0
    property int portrait: 90

    Item {
        id: blurrable
        anchors.fill: parent

        Wallpaper {
        }

        TitleBar {
            id: titleBar

            onClicked: {
                launcher.show();
            }

            Rectangle {
                anchors.right: switcherRect.left
                anchors.rightMargin: 5
                anchors.top: titleBar.top
                anchors.bottom: titleBar.bottom
                color: "red"

                width: rotateButton.paintedWidth + 30

                Text {
                    id: rotateButton
                    anchors.centerIn: parent
                    text: "Rotate"
                }

                MouseArea {
                    anchors.fill: parent
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
            }

            Rectangle {
                id: switcherRect
                anchors.right: titleBar.right
                anchors.top: titleBar.top
                anchors.bottom: titleBar.bottom
                color: "red"
                width: switcherButton.paintedWidth + 30

                Text {
                    id: switcherButton
                    anchors.centerIn: parent
                    text: "Open Switcher"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: switcher.show()
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

    Switcher {
        id: switcher
    }

    Launcher {
        id: launcher
    }

    FPSMonitor {
    }
}
