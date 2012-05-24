import QtQuick 2.0

Item {
    id: switcher
    anchors.fill: parent
    opacity: 0

    Rectangle {
        id: wallpaper
        color: "black"
        opacity: 0.5
        anchors.fill: parent
    }

    ListModel {
        id: windowModel
        ListElement {
            name: "My Friend - Messaging"
            icon: "NokiaN9sms02.png"
        }

        ListElement {
            name: "Facebook"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-4.png"
        }
        ListElement {
            name: "Sharing... - Facebook"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-7.png"
        }
        ListElement {
            name: "Wazapp"
            icon: "2012-05-06_22-13-25.png"
        }
        ListElement {
            name: "Share - Facebook"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-5.png"
        }
        ListElement {
            name: "Facebook"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-8.png"
        }
        ListElement {
            name: "Another Friend - Messaging"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-24.png"
        }
        ListElement {
            name: "Facebook"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-6.png"
        }
        ListElement {
            name: "Messages - Facebook"
            icon: "Nokia-N9-N950-MeeGo-OS-review-huge-Part-2-9.png"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: hide()
    }

    GridView {
        id: grid
        anchors.fill: parent
        anchors.margins: 50
        anchors.topMargin: 70 // XXX: FIXME: hardcoded, should be toolbar height
        cellHeight: width / 3
        cellWidth: cellHeight
        model: windowModel
        delegate: Item {
            id: delegate
            width: grid.cellWidth
            height: grid.cellHeight

            Text {
                id: textItem
                text: name;
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
            }

            Image {
                id: iconItem
                width: grid.cellWidth - 30
                fillMode: Image.PreserveAspectFit
                source: "windows/" + icon;
                anchors.top: textItem.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                anchors.top: textItem.top
                anchors.bottom: iconItem.bottom
                anchors.right: iconItem.width > textItem.width ? iconItem.right : textItem.right
                anchors.left: iconItem.x < textItem.x ? iconItem.left : textItem.left
                onClicked: {
                    viewer.show(iconItem)
                }
            }
        }
    }

    Image {
        id: viewer
        property bool isOpen: false
        property int oheight
        property int owidth
        anchors.centerIn: parent
        visible: width != owidth

        function show(item) {
            source = item.source

            height = oheight = item.height
            width = owidth = item.width
            opacity = 1

            isOpen = true
            width = switcher.width
            height = switcher.height
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
            enabled: viewer.isOpen
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 500
            }
        }
        Behavior on width {
            enabled: viewer.isOpen
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 500
            }
        }
        Behavior on opacity {
            enabled: viewer.isOpen
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: 400
            }
        }
    }

    function show() {
        // TODO: would be nice to have this set by a binding somehow
        homeScreen.blurRadius = 32
        opacity = 1
    }

    function hide() {
        homeScreen.blurRadius = 0
        opacity = 0
    }

    Behavior on opacity {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
}
