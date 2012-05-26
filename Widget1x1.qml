import QtQuick 2.0

import "constants.js" as Constants

Item {
    width: {
        if (homeScreen.orientation == Constants.landscape)
           return Math.floor(homeScreen.width / 4)
        else
           return Math.floor(homeScreen.width / 3)
   }
    height: {
        if (homeScreen.orientation == Constants.landscape)
            return Math.floor((homeScreen.height - homeScreen.titleBar.height) / 3)
        else
            return Math.floor((homeScreen.height - homeScreen.titleBar.height) / 4)
    }
}
