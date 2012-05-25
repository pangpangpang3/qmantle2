import QtQuick 2.0

Rectangle {
    anchors.rightMargin: 5
    anchors.top: titleBar.top
    anchors.bottom: titleBar.bottom
    color: "red"

    width: myButton.paintedWidth + 30

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

