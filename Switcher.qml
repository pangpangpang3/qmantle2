import QtQuick 2.0

PanelBase {
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

            isOpen = true
            width = panelBase.width
            height = panelBase.height
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
}
