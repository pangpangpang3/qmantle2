import QtQuick 1.1

Image {
    id: window
    property bool isOpen: false
    property int oheight
    property int owidth
    opacity: 0

    property int oldx
    property int oldy

    function show(item, thumbx, thumby) {
        source = item.source

        x = oldx = thumbx
        y = oldy = thumby
        height = oheight = item.height
        width = owidth = item.width
        opacity = 1

        isOpen = true
        width = parent.width
        height = parent.height
        x = 0
        y = 0
    }

    function close() {
        height = oheight
        width = owidth
        opacity = 0
        x = oldx
        y = oldy
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
            duration: 500
        }
    }
    Behavior on x {
        enabled: window.isOpen
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
    Behavior on y {
        enabled: window.isOpen
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
}

