import QtQuick 2.0

import "constants.js" as Constants

Item {
    property int baseWidth: {
        if (homeScreen.orientation == Constants.landscape)
           return homeScreen.width / 4
        else
           return homeScreen.width / 3
    }
    property int baseHeight: {
        if (homeScreen.orientation == Constants.landscape)
            return (homeScreen.height - homeScreen.titleBar.height) / 3
        else
            return (homeScreen.height - homeScreen.titleBar.height) / 4
    }

    property int requiredXCells: 1
    property int requiredYCells: 1

    width: baseWidth * requiredXCells
    height: baseHeight * requiredYCells
}
