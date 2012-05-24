import QtQuick 2.0

Image {
    id: wallpaper
    property var anim: wallpaperAnim
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    NumberAnimation {
        id: wallpaperAnim
        target: wallpaper
        properties: "x"
        from: wallpaper.x
        easing.type: Easing.OutExpo
        duration: 400
    }
}

