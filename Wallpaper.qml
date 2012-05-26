import QtQuick 2.0

import "constants.js" as Constants

Image {
    id: wallpaper
    property var behavior: wallpaperBehavior
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    sourceSize.width: Constants.screen.width
    sourceSize.height: Constants.screen.height
    width: parent.width
    property int initialX
    asynchronous: true
    fillMode: Image.PreserveAspectCrop

    onInitialXChanged: setPosition(initialX)

    function setPosition(newX) {
        wallpaperBehavior.enabled = false;
        x = newX
        wallpaperBehavior.enabled = true
    }

    Behavior on x {
        id: wallpaperBehavior
        NumberAnimation {
            easing.type: Easing.OutExpo
            duration: 400
        }
    }

    // widgets
    WidgetLayout {
        anchors.fill: parent
        anchors.topMargin: homeScreen.titleBar.height

        Widget2x1 {
            id: widgetone
            LauncherIcon {
                anchors.fill: parent
                title: "Phone"
                iconId: "icon-l-telephony.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Mail"
                iconId: "icon-l-mail.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Contacts"
                iconId: "icon-l-contacts.png"
            }
        }
        Widget2x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }
        Widget2x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Phone"
                iconId: "icon-l-telephony.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Mail"
                iconId: "icon-l-mail.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Contacts"
                iconId: "icon-l-contacts.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }

        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Phone"
                iconId: "icon-l-telephony.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Mail"
                iconId: "icon-l-mail.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Contacts"
                iconId: "icon-l-contacts.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }

        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Phone"
                iconId: "icon-l-telephony.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Mail"
                iconId: "icon-l-mail.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Contacts"
                iconId: "icon-l-contacts.png"
            }
        }
        Widget1x1 {
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }
    }
}

