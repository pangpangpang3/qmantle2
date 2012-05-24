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

    Launcher {
        id: launcher
    }

    FPSMonitor {
    }
}
