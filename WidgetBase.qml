import QtQuick 2.0

import "constants.js" as Constants

Item {
    property int baseWidth: {
        if (homeScreen.orientation == Constants.landscape)
           return Math.floor(homeScreen.width / 4)
        else
           return Math.floor(homeScreen.width / 3)
    }
    property int baseHeight: {
        if (homeScreen.orientation == Constants.landscape)
            return Math.floor((homeScreen.height - homeScreen.titleBar.height) / 3)
        else
            return Math.floor((homeScreen.height - homeScreen.titleBar.height) / 4)
    }
}
