import QtQuick 1.1

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
    onChildrenChanged: if (!relayout.running) relayout.restart()
    onWidthChanged: if (!relayout.running) relayout.restart()
    onHeightChanged: if (!relayout.running) relayout.restart()

    Timer {
        id: relayout
        interval: 16
        running: false
        repeat: false
        onTriggered: performLayout()
    }

    /* just as endless layouts are harmful, so too is trying to layout before
     * the component (and its children) are fully loaded.
     */
    Component.onCompleted: {
        ready = true
        if (!relayout.running) relayout.restart()
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

    /* determines whether \a obj can fit at the specified \a x and \a y
     * coordinates of the \a grid, given the desired size of the object.
     */
    function canFit(grid, obj, x, y) {
        if (y + obj.requiredYCells > grid.length || x + obj.requiredXCells > grid[y].length) {
            console.log("Too long at " + x + "x" + y)
            return false
        }

        /* check if all required cells starting at x,y are free. */
        for (var checkY = y; checkY < y + obj.requiredYCells; checkY++) {
            for (var checkX = x; checkX < x + obj.requiredXCells; checkX++) {
//                console.log("CHECKING " + checkX + "x" + checkY)
                if (grid[checkY][checkX])
                    return false
            }
        }

//        console.log("Not taken at " + x + "x" + y)
        return true
    }

    /* find a space in the grid to fit \a obj in \a grid, keeping its required size in mind
     */
    function findPositionFor(grid, obj) {
        if (homeScreen.orientation == Constants.landscape && obj.desiredXLandscape != undefined)
            if (canFit(grid, obj, obj.desiredXLandscape, obj.desiredYLandscape))
                return { x: obj.desiredXLandscape, y: obj.desiredYLandscape }
        else if (obj.desiredXPortrait != undefined)
            if (canFit(grid, obj, obj.desiredXPortrait, obj.desiredYPortrait))
                return { x: obj.desiredXPortrait, y: obj.desiredYPortrait }

        for (var currentY = 0; currentY < grid.length; ++currentY) {
            for (var currentX = 0; currentX < grid[currentY].length; ++currentX) {
//                console.log("Checking canFit for " + currentX + "x" + currentY)
                if (canFit(grid, obj, currentX, currentY))
                    return { x: currentX, y: currentY }
            }
        }

        return undefined
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

            console.log("Trying to find a space in the grid for object of size " + obj.requiredXCells + "x" + obj.requiredYCells)
            //printGrid(grid)

            var pos = findPositionFor(grid, obj)

            /* this is pretty bad: object won't fit on the grid, so it won't be
             * visible to the user at all. there's really nothing we can do
             * about this though.
             */
            if (pos == undefined) {
                console.log("object of " + obj.requiredXCells + "x" + obj.requiredYCells + " won't fit in the available space")
                obj.visible = false
                continue
            }

            /* if we can fit here, then claim these lands. */
            console.log("Positioning at " + pos.x + "x" + pos.y + " to " + (pos.x + obj.requiredXCells) + "x" + (pos.y + obj.requiredYCells))
            obj.visible = true
            obj.x = obj.baseWidth * pos.x
            obj.y = obj.baseHeight * pos.y

            for (var checkY = pos.y; checkY < pos.y + obj.requiredYCells; ++checkY) {
                for (var checkX = pos.x; checkX < pos.x + obj.requiredXCells; ++checkX) {
                    // place it
                    grid[checkY][checkX] = obj
                }
            }

            //printGrid(grid)
        }

        console.log("LAYOUT DONE")
    }
}
