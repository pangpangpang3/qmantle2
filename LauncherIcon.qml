import QtQuick 2.0

Item {
    Image {
        id: iconItem
        source: "meego-handset-theme-darko/meegotouch/icons/" + icon;
        asynchronous: true
        anchors.centerIn: parent
    }

    Text {
        id: textItem
        text: name;
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
            console.log("Clicked on " + name)
        }
    }
}
