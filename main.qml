import QtQuick 2.0

Item {
    id: homeScreen;
    width: 960;
    height: 600;

    function toggleModeChange() {
        launcher.show();
    }

    Wallpaper {
    }

    TitleBar {
    }

    Launcher {
        id: launcher
    }
}
