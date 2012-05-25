import QtQuick 2.0

Image {
    id: window
    property bool isOpen: false
    property int oheight
    property int owidth
    anchors.centerIn: parent
    visible: width != owidth

    function show(item) {
        source = item.source

        height = oheight = item.height
        width = owidth = item.width

        isOpen = true
        width = parent.width
        height = parent.height
        opacity = 1
    }

    function close() {
        height = oheight
        width = owidth
        opacity = 0
        isOpen = false
    }

    MouseArea {
        anchors.fill: parent
        enabled: parent.isOpen
        onClicked: parent.close()
    }

    Behavior on height {
        enabled: window.isOpen
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
    Behavior on width {
        enabled: window.isOpen
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
    Behavior on opacity {
        enabled: window.isOpen
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 400
        }
    }
}

