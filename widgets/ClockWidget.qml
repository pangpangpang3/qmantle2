import QtQuick 2.0

import ".."
import "../constants.js" as Constants

Widget {
    id : clock
    property int hours
    property int minutes
    property int seconds

    function timeChanged() {
        var date = new Date;
        hours = date.getHours()
        minutes = date.getMinutes()
        seconds = date.getUTCSeconds();
    }

    Timer {
        interval: 1000; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }

    content: [
         Rectangle {
            anchors.centerIn: parent
            height: (parent.height > parent.width) ? parent.width : parent.height
            width: height
            color: "black"

            Rectangle {
                id: _12
                width: 4
                height: parent.height / 15
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: _3
                width: parent.height / 15
                height: 4
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                id: _6
                width: 4
                height: parent.height / 15
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: _9
                width: parent.height / 15
                height: 4
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 4
                height: parent.height * 0.35
                color: "white"
                // XXX: we can't always add/subtract width / 2, what we need to do
                // depends on the angle
                x: (parent.width / 2) - (width / 2)
                y: (parent.height / 2) + (width / 2)
                transform: Rotation {
                    id: hourRotation
                    angle: ((clock.hours * 30) + (clock.minutes * 0.5)) - 180
                    Behavior on angle {
                        SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                    }
                }
            }

            Rectangle {
                width: 3
                height: parent.height * 0.45
                color: "white"
                x: (parent.width / 2) - (width / 2)
                y: (parent.height / 2) + (width / 2)
                transform: Rotation {
                    id: minuteRotation
                    angle: (clock.minutes * 6) - 180
                    Behavior on angle {
                        SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                    }
                }
            }

            Rectangle {
                width: 2
                height: parent.height * 0.45
                color: "red"
                x: (parent.width / 2) - (width / 2)
                y: (parent.height / 2) + (width / 2)
                transform: Rotation {
                    id: secondRotation
                    angle: (clock.seconds * 6) - 180
                    Behavior on angle {
                        SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                    }
                }
            }

            Rectangle {
                anchors.centerIn: parent
                height: 10
                width: 10
                radius: 360
                color: "white"
            }
        }
    ]
}
