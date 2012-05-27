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

        Widget {
            requiredYCells: 2
            Rectangle {
                anchors.fill: parent
                color: "blue"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Phone"
                iconId: "icon-l-telephony.png"
            }
        }
        Widget {
            requiredXCells: 2
            Rectangle {
                anchors.fill: parent
                color: "gray"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Mail"
                iconId: "icon-l-mail.png"
            }
        }
        Widget {
            Rectangle {
                anchors.fill: parent
                color: "red"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Contacts"
                iconId: "icon-l-contacts.png"
            }
        }
        Widget {
            requiredXCells: 2
            Rectangle {
                anchors.fill: parent
                color: "orange"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }
        Widget {
            requiredXCells: 2
            Rectangle {
                anchors.fill: parent
                color: "pink"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Phone"
                iconId: "icon-l-telephony.png"
            }
        }
        Widget {
            Rectangle {
                anchors.fill: parent
                color: "green"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Mail"
                iconId: "icon-l-mail.png"
            }
        }
        Widget {
            requiredYCells: 2
            Rectangle {
                anchors.fill: parent
                color: "black"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Contacts"
                iconId: "icon-l-contacts.png"
            }
        }
        Widget {
            Rectangle {
                anchors.fill: parent
                color: "black"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }
        Widget {
            Rectangle {
                anchors.fill: parent
                color: "green"
                opacity: 0.5
            }
            LauncherIcon {
                anchors.fill: parent
                title: "Notes"
                iconId: "icon-l-notes.png"
            }
        }
    }
}

