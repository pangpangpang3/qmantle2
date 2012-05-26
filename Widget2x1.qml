import QtQuick 2.0

import "constants.js" as Constants

Item {
    Widget1x1 {
        id: stubWidget
        visible: false
    }
    width: stubWidget.width * 2
    height: stubWidget.height
}
