import QtQuick 1.0

Rectangle {
    color: "red"

    width: myButton.paintedWidth * 3
    height: myButton.paintedHeight * 5
    anchors.leftMargin: 10
    anchors.top: parent.top

    property alias text: myButton.text
    signal clicked

    Text {
        id: myButton
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
    }
}

