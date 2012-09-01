import QtQuick 2.0

MouseArea {
    property alias title: textItem.text
    property string iconId
    height: iconItem.height + textItem.height
    width: iconItem.width > textItem.width ? iconItem.width : textItem.width

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

    onClicked: {
        console.log("Clicked on " + title)
    }
}

