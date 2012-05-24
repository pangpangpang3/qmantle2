import QtQuick 2.0

Item {
    id: launcher
    state: "invisible"
    property bool fuckingVisible: false // yes, this is hideous, but setting state directly breaks
    anchors.fill: parent

    Rectangle {
        id: wallpaper
        color: "black"
        width: 400
        height: 500
        opacity: 0.8
        anchors.fill: parent
    }

    ListModel {
        id: applicationsModel
        ListElement {
            name: "Phone"
            icon: "icon-l-telephony.png"
        }
        ListElement {
            name: "Mail"
            icon: "icon-l-mail.png"
        }
        ListElement {
            name: "Contacts"
            icon: "icon-l-contacts.png"
        }
        ListElement {
            name: "Notes"
            icon: "icon-l-notes.png"
        }
        ListElement {
            name: "Clock"
            icon: "icon-l-clock.png"
        }
        ListElement {
            name: "Calendar"
            icon: "icon-l-calendar.png"
        }
        ListElement {
            name: "Music"
            icon: "icon-l-music.png"
        }
        ListElement {
            name: "Camera"
            icon: "icon-l-camera.png"
        }
        ListElement {
            name: "Gallery"
            icon: "icon-l-gallery.png"
        }
        ListElement {
            name: "Maps"
            icon: "icon-l-maps.png"
        }
        ListElement {
            name: "Calculator"
            icon: "icon-l-calculator.png"
        }
        ListElement {
            name: "Messages"
            icon: "icon-l-conversation.png"
        }
        ListElement {
            name: "Search"
            icon: "icon-l-search.png"
        }
        ListElement {
            name: "Me"
            icon: "icon-l-me.png"
        }
        ListElement {
            name: "Office Tools"
            icon: "icon-l-office-tools.png"
        }
        ListElement {
            name: "RSS"
            icon: "icon-l-rss.png"
        }
        ListElement {
            name: "Settings"
            icon: "icon-l-settings.png"
        }
        ListElement {
            name: "Drive"
            icon: "icon-l-drive.png"
        }
        ListElement {
            name: "Facebook"
            icon: "icon-l-facebook.png"
        }
        ListElement {
            name: "Terminal"
            icon: "icon-l-terminal.png"
        }
        ListElement {
            name: "Firefox"
            icon: "icon-l-firefox.png"
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
        cellHeight: width / 7
        cellWidth: cellHeight
        model: applicationsModel
        delegate: Item {
            width: grid.cellWidth
            height: grid.cellHeight

            Image {
                id: iconItem
                source: "meego-handset-theme-darko/meegotouch/icons/" + icon;
                anchors.horizontalCenter: parent.horizontalCenter
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
    }

    // TODO: basing this off homeScreen.mode using states would be nicer, but
    // doesn't seem to work
    function show() {
        fuckingVisible = true
    }

    function hide() {
        fuckingVisible = false
    }

    states: [
        State {
            name: "visible"
            when: fuckingVisible
            PropertyChanges {
                target: launcher
                opacity: 1
            }
        },

        State {
            name: "invisible"
            when: !fuckingVisible
            PropertyChanges {
                target: launcher
                opacity: 0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "opacity"
            easing.type: Easing.InOutQuad
            duration: 500
        }
    }
}
