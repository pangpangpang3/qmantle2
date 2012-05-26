import QtQuick 2.0

Item {
    property alias title: textItem.text
    property string iconId
    Image {
        id: iconItem
        source: "assets/launchericons/" + parent.iconId;
        asynchronous: true
        anchors.centerIn: parent
    }

    Text {
        id: textItem
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: iconItem.bottom
        color: "white"
    }

    MouseArea {
        anchors.top: iconItem.top
        anchors.bottom: textItem.bottom
        anchors.right: iconItem.width > textItem.width ? iconItem.right : textItem.right
        anchors.left: iconItem.x < textItem.x ? iconItem.left : textItem.left
        onClicked: {
            console.log("Clicked on " + parent.title)
        }
    }
}

