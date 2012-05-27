import QtQuick 2.0

import "constants.js" as Constants

Item {
    id: layout

    property bool ready: false
    onChildrenChanged: relayout.restart()
    onWidthChanged: relayout.restart()
    onHeightChanged: relayout.restart()

    Timer {
        id: relayout
        interval: 0
        running: false
        repeat: false
        onTriggered: performLayout()
    }

    Component.onCompleted: {
        ready = true
        relayout.restart()
    }

    function printGrid(grid) {
        var currentY = 0
        var str = "   | "
        for (var i = 0; i < grid[0].length; ++i) {
            str += i + " || "
        }
        str += "\n"
        for (; currentY < grid.length; currentY++) {
            str += currentY + ": "
            for (var currentX = 0; currentX < grid[currentY].length; currentX++) {
                if (grid[currentY][currentX])
                    str += "[ x ]"
                else
                    str += "[   ]"
            }

            str += "\n"
        }

        console.log(str)
    }

    // XXX: we should furthermore strive to use anchors to position items instead of
    // fixing their positions. anchor the top left item to our container, anchor
    // all subsequent widgets to it.
    //
    // we can also then reuse this grid for saving of positioning, one day.
    function performLayout() {
        if (!layout.ready) {
            // we mustn't do any layout before fully loaded, otherwise we're
            // just wasting our time.
            return;
        }

        var grid
        if (homeScreen.orientation == Constants.landscape) {
            console.log("Landscape grid")
            grid = [ [ 0, 0, 0, 0 ],
                     [ 0, 0, 0, 0 ],
                     [ 0, 0, 0, 0 ] ]
        } else {
            grid = [ [ 0, 0, 0 ],
                     [ 0, 0, 0 ],
                     [ 0, 0, 0 ],
                            [ 0, 0, 0 ] ]
        }

        printGrid(grid)

        console.log("DOING LAYOUT FOR " + layout.children.length + " ITEMS")

        for (var i = 0; i < layout.children.length; ++i) {
            var obj = layout.children[i]

            console.log("Trying to find a space in the grid for object of size " + obj.requiredXCells + "x" + obj.requiredYCells)

            var currentY = 0
            var positioned = false

            for (; !positioned && currentY < grid.length; currentY++) {
                for (var currentX = 0; !positioned && currentX < grid[currentY].length; currentX++) {
                    if (!grid[currentY][currentX]) {
                        var taken = false
                        var checkY = currentY

                        for (; !taken && checkY < grid.length; checkY++) {
                            for (var checkX = currentX; !taken && checkX < grid[checkY].length; checkX++) {
                                if (grid[checkY][checkX]) {
                                    console.log("Taken at " + checkX + "x" + checkY)
                                    taken = true
                                    break;
                                }
                            }
                        }

                        if (!taken) {
                            console.log("Positioning at " + currentX + "x" + currentY)
                            positioned = obj.visible = true
                            var checkY = currentY

                            // TODO: replace with anchors
                            obj.x = currentX * widgetBase.baseWidth
                            obj.y = currentY * widgetBase.baseHeight
                            for (; checkY < currentY + obj.requiredYCells; ++checkY) {
                                for (var checkX = currentX; checkX < currentX + obj.requiredXCells; ++checkX) {
                                    // place it
                                    grid[checkY][checkX] = obj
                                }
                            }

                            printGrid(grid)
                        }
                    }
                }
            }

            if (!positioned) {
                console.log("object of " + obj.requiredXCells + "x" + obj.requiredYCells + " won't fit in the available space")
                obj.visible = false
            }
        }

        console.log("LAYOUT DONE")
    }

    // TODO: replace with anchors
    Widget {
        id: widgetBase
        visible: false
    }
}
