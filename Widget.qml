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

    Item {
        id: widgetContent
        anchors.fill: parent
        anchors.margins: 10
    }

    Behavior on x {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 300
        }
    }

    Behavior on y {
        NumberAnimation {
            easing.type: Easing.InOutQuad
            duration: 300
        }
    }


}
