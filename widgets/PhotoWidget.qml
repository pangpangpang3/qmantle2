import QtQuick 2.0

import ".."

Widget {
    property alias source: photoImage.source
    property int _maxBaseWidth: baseWidth
    property int _maxBaseHeight: baseHeight

    onBaseWidthChanged: {
        if (baseWidth > _maxBaseWidth)
            _maxBaseWidth = baseWidth
    }

    onBaseHeightChanged: {
        if (baseHeight > _maxBaseHeight)
            _maxBaseHeight = baseHeight
    }

    content: [
         Rectangle {
            color: "white"
            anchors.fill: parent

            Image {
                id: photoImage
                anchors.fill: parent
                anchors.margins: 10
                sourceSize.width: _maxBaseWidth
                sourceSize.height: _maxBaseHeight
                fillMode: Image.PreserveAspectCrop
                source: "../assets/wallpapers/wallpaper.jpg"
            }
         }
    ]
}
