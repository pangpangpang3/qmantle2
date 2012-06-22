import QtQuick 2.0

import "constants.js" as Constants

PanelBase {
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

    GridView {
        id: grid
        anchors.fill: parent
        anchors.margins: 30
        cellHeight: homeScreen.orientation == Constants.landscape ? width / 5 : width / 3
        cellWidth: cellHeight
        model: applicationsModel
        delegate: LauncherIcon {
            width: grid.cellWidth
            height: grid.cellHeight
            title: name
            iconId: icon
        }
    }
}
