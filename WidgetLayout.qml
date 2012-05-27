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

        console.log("DOING LAYOUT FOR " + layout.children.length + " ITEMS")

        for (var i = 0; i < layout.children.length; ++i) {
            var obj = layout.children[i]

            obj.anchors.top = undefined
            obj.anchors.bottom = undefined
            obj.anchors.left = undefined
            obj.anchors.right = undefined

            console.log("Trying to find a space in the grid for object of size " + obj.requiredXCells + "x" + obj.requiredYCells)
            //printGrid(grid)

            var currentY = 0
            var positioned = false

            for (; !positioned && currentY < grid.length; currentY++) {
                if (currentY + obj.requiredYCells > grid.length)
                    break
                for (var currentX = 0; !positioned && currentX < grid[currentY].length; currentX++) {
                    if (currentX + obj.requiredXCells > grid[currentY].length)
                        break
                    if (!grid[currentY][currentX]) {
                        var taken = false
                        var checkY = currentY

                        for (; !taken && checkY < currentY + obj.requiredYCells; checkY++) {
                            for (var checkX = currentX; !taken && checkX < currentX + obj.requiredXCells; checkX++) {
                                if (grid[checkY][checkX]) {
                                    console.log("Taken at " + checkX + "x" + checkY)
                                    taken = true
                                    break;
                                }
                            }
                        }

                        if (!taken) {
                            console.log("Positioning at " + currentX + "x" + currentY + " to " + (currentX + obj.requiredXCells) + "x" + (currentY + obj.requiredYCells))
                            positioned = obj.visible = true
                            var checkY = currentY

                            for (; checkY < currentY + obj.requiredYCells; ++checkY) {
                                for (var checkX = currentX; checkX < currentX + obj.requiredXCells; ++checkX) {
                                    // place it
                                    grid[checkY][checkX] = obj
                                }
                            }

                            // anchor it
                            // TODO: we should delay anchoring until the grid is
                            // setup, perhaps
                            if (currentX == 0) {
                                obj.anchors.left = layout.left
                            } else {
                                for (var checkX = currentX - 1; ; checkX--) {
                                    if (checkX < 0) {
                                        console.log("CANNOT CREATE LEFT ANCHOR")
                                        break
                                    }

                                    if (grid[currentY][checkX]) {
                                        obj.anchors.left = grid[currentY][checkX].right
                                        break
                                    }
                                }
                            }

                            if (currentY == 0) {
                                obj.anchors.top = layout.top
                            } else {
                                for (checkY = currentY - 1; ; checkY--) {
                                    if (checkY < 0) {
                                        console.log("CANNOT CREATE LEFT ANCHOR")
                                        break;
                                    }

                                    if (grid[checkY][currentX]) {
                                        obj.anchors.top = grid[checkY][currentX].bottom
                                        break
                                    }
                                }
                            }

                            //printGrid(grid)
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
}
