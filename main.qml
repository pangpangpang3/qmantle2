import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: homeScreen;
    width: 960;
    height: 600;
    property alias blurRadius: blur.radius

    function toggleModeChange() {
        launcher.show();
    }

    Item {
        id: blurrable
        anchors.fill: parent

        Wallpaper {
        }

        TitleBar {
            id: titleBar

            Rectangle {
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
