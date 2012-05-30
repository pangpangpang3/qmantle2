import QtQuick 2.0

import ".."

Widget {
    property alias source: photoImage.source

    content: [
         Rectangle {
            color: "white"
            anchors.fill: parent

            Image {
                id: photoImage
                anchors.fill: parent
                anchors.margins: 10
                sourceSize.width: baseWidth
                sourceSize.height: baseHeight
                fillMode: Image.PreserveAspectCrop
                source: "../assets/wallpapers/wallpaper.jpg"
            }
         }
    ]
}
