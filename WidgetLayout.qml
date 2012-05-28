import QtQuick 2.0

import "constants.js" as Constants

/* effectively a layout.
 *
 * given a list of children Items with a desired height and width in cell
 * coordinates, places items on a grid in such a way that it will try to fit
 * everything in.
 */
Item {
    id: layout

    property bool ready: false

    /* performing layout constantly without some pause is detrimental: there's
     * no point laying out the grid only for another item to be added, and to
     * have to lay it out again.
     *
     * so we use a 0ms timer to trigger a relayout when the mainloop has ticked
     * again.
     */
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

    /* just as endless layouts are harmful, so too is trying to layout before
     * the component (and its children) are fully loaded.
     */
    Component.onCompleted: {
        ready = true
        relayout.restart()
    }

    /* little debugging tool: useful for diagnosing problems in grid positioning
     */
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

    /* the meat of the layout */
    function performLayout() {
        if (!layout.ready) {
            /* we mustn't do any layout before fully loaded, otherwise we're
             * just wasting our time.
             */
            return;
        }

        if (layout.children.length == 0)
            return

        /* we start the layout process by creating an empty grid which will fit
         * the requisite number of cells.
         */
        var grid = []
        var rows = homeScreen.orientation == Constants.landscape ? Constants.homescreenWidgetRowsLandscape : Constants.homescreenWidgetRowsPortrait
        var cols = homeScreen.orientation == Constants.landscape ? Constants.homescreenWidgetColumnsLandscape : Constants.homescreenWidgetColumnsPortrait

        for (var i = 0; i < rows; ++i) {
            grid.push([])
            for (var j = 0; j < cols; ++j) {
                grid[i].push(0)
            }
        }

        console.log("DOING LAYOUT FOR " + layout.children.length + " ITEMS")

        /* first real step of doing anything: go over all the children, find out
         * how big they want to be when they grow up, and try find space in the
         * grid to plonk them into.
         */
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
                /* if the object is too tall to fit in the grid, then just stop
                 * now, there's no point proceeding further
                 */
                if (currentY + obj.requiredYCells > grid.length)
                    break
                for (var currentX = 0; !positioned && currentX < grid[currentY].length; currentX++) {
                    /* if the object is too long to fit on this row, then
                     * proceed to the next row.
                     */
                    if (currentX + obj.requiredXCells > grid[currentY].length)
                        break

                    /* check if this cell is free. if it is, check if the
                     * adjacent required cells are free, and if they are, we're
                     * in luck.
                     */
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

                        /* if we can fit here, then claim these lands. */
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

                            //printGrid(grid)
                        }
                    }
                }
            }

            /* this is pretty bad: object won't fit on the grid, so it won't be
             * visible to the user at all. there's really nothing we can do
             * about this though.
             */
            if (!positioned) {
                console.log("object of " + obj.requiredXCells + "x" + obj.requiredYCells + " won't fit in the available space")
                obj.visible = false
            }
        }

        console.log("LAYOUT DONE, anchoring")

        /* once we've laid out the grid more or less how we want it, we need to
         * anchor items together to ensure that when the layout moves, the items
         * within it move as well.
         */
        var currentY = 0
        for (; currentY < grid.length; currentY++) {
            for (var currentX = 0; currentX < grid[currentY].length; currentX++) {
                var obj = grid[currentY][currentX]
                if (obj) {
                    for (var checkX = currentX - 1; ; checkX--) {
                        if (checkX < 0) {
                            // probably on the left-most cell
                            obj.anchors.left = layout.left
                            break
                        }

                        if (grid[currentY][checkX]) {
                            if (grid[currentY][checkX] != obj)
                                obj.anchors.left = grid[currentY][checkX].right
                            break
                        }
                    }

                    for (var checkY = currentY - 1; ; checkY--) {
                        if (checkY < 0) {
                            // probably on the top-most cell
                            obj.anchors.top = layout.top
                            break;
                        }

                        if (grid[checkY][currentX]) {
                            if (grid[checkY][currentX] != obj)
                                obj.anchors.top = grid[checkY][currentX].bottom
                            break
                        }
                    }
                }
            }
        }
    }
}
