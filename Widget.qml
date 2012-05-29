import QtQuick 2.0

import "constants.js" as Constants

Item {
    property alias content: widgetContent.children
    property int baseWidth: {
        if (homeScreen.orientation == Constants.landscape)
           return homeScreen.width / Constants.homescreenWidgetColumnsLandscape
        else
           return homeScreen.width / Constants.homescreenWidgetColumnsPortrait
    }
    property int baseHeight: {
        if (homeScreen.orientation == Constants.landscape)
            return (homeScreen.height - homeScreen.titleBar.height) / Constants.homescreenWidgetRowsLandscape
        else
            return (homeScreen.height - homeScreen.titleBar.height) / Constants.homescreenWidgetRowsPortrait
    }

    property int requiredXCells: 1
    property int requiredYCells: 1

    width: baseWidth * requiredXCells
    height: baseHeight * requiredYCells

    Behavior on x {
        NumberAnimation {
            duration: 200
        }
    }

    Behavior on y {
        NumberAnimation {
            duration: 200
        }
    }

    Rectangle {
        anchors.fill: parent
        opacity: 0.5
        Component.onCompleted: {
             var hex1=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")
             var hex2=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")
             var hex3=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")
             var hex4=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")
             var hex5=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")
             var hex6=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F")
             var bg="#"+hex1[Math.floor(Math.random()*hex1.length)]+hex2[Math.floor(Math.random()*hex2.length)]+hex3[Math.floor(Math.random()*hex3.length)]+hex4[Math.floor(Math.random()*hex4.length)]+hex5[Math.floor(Math.random()* hex5.length)]+hex6[Math.floor(Math.random()*hex6.length)]
            color = bg
        }
    }

    Item {
        id: widgetContent
        anchors.fill: parent
        anchors.margins: 10
    }
}
