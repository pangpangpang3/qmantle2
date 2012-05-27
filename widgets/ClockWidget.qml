import QtQuick 2.0

import ".."

Widget {
    id: clock
    Rectangle {
        anchors.centerIn: parent
        width: parent.height
        height: parent.width
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.rgba(0, 0, 0, 0) }
            GradientStop { position: 1; color: Qt.rgba(0, 0, 0, 255) }
        }

        rotation: 90
    }

    Text {
        id: time
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        font.pixelSize: parent.width / 3
    }

    Text {
        id: date
        anchors.top: time.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        font.pixelSize: time.font.pixelSize * 0.3
    }

    function timeChanged() {
        var jsdate = new Date;
        time.text = Qt.formatTime(jsdate)
        date.text = Qt.formatDate(jsdate, Qt.DefaultLocaleLongDate)

        // TODO: maybe use a day/night determination to give it some funky
        // feeling
    }

    Component.onCompleted: timeChanged()

    Timer {
        interval: 60300; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }
}
