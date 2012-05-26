import QtQuick 2.0
import QtGraphicalEffects 1.0

import "constants.js" as Constants

Item {
    id: homeScreen;
    width: Constants.screen.width
    height: Constants.screen.height
    clip: true

    property alias titleBar: titleBar
    property int orientation: Constants.landscape

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

        WallpaperController {
        }

        TitleBar {
            id: titleBar

            onClicked: {
                Constants.loadSingleton("Launcher.qml", homeScreen, function(launcher) {
                    launcher.showing.connect(function() {
                        blur.radius = 32
                    });
                    launcher.hiding.connect(function() {
                        blur.radius = 0
                    });

                    launcher.show();
                });
            }

            Rectangle {
                color: "red"
                anchors.right: titleBar.right
                anchors.top: titleBar.top
                anchors.bottom: titleBar.bottom
                width: switcherOpenText.paintedWidth

                Text {
                    id: switcherOpenText
                    text: "Open Switcher"
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Constants.loadSingleton("Switcher.qml", homeScreen, function(switcher) {
                            switcher.showing.connect(function() {
                                blur.radius = 32
                            });
                            switcher.hiding.connect(function() {
                                blur.radius = 0
                            });
                            switcher.show();
                        });
                    }
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
}

