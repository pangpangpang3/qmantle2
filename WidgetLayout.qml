import QtQuick 2.0

Item {
    id: layout
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

    // XXX: this is really really crap. we have too much pixel maths going on,
    // which breaks really really easily in 1) the case of forgotten rounding
    // (already happened) or 2) the case of rotations causing fractional amounts
    // (which is also happening).
    //
    // a much much more robust design is possible; because we know the desired
    // widths of widgets: simply assign a 'grid' of taken positions (where taken
    // means filled with a widget), and on layout, walk each child, finding a
    // place in the grid where it'll fit (e.g. if it needs 2x1, look for a 2x1
    // shaped hole...) marking the grid as filled as we progress.
    //
    // we can also then reuse this grid for saving of positioning, one day.
    function performLayout() {
        var itemsPlaced = 0
        var currentX = 0
        var currentY = 0
        var rowMaxY = 0 // highest item in this row

        console.log("DOING LAYOUT FOR " + layout.children.length + " ITEMS")

        for (var i = 0; i < layout.children.length; ++i) {
            // 1x1 = 186x186
            // 2x1 = 385x186
            // 1x2 = 186x385
            var obj = layout.children[i]

            if (obj.width + currentX > layout.width) {
                console.log("too big, currentX " + currentX + " width " + obj.width + " my width " + layout.width)
                // move to next row
                currentX = 0
                currentY = currentY + rowMaxY
                rowMaxY = 0
                itemsPlaced = 0
                console.log("Next row at " + currentY)
            }

            if (obj.height > rowMaxY) {
                console.log("rowMaxY is " + obj.height)
                rowMaxY = obj.height
            }

            console.log("Laying out an item size: " + obj.width + "x" + obj.height + " at " + currentX + "x" + currentY)
            obj.x = currentX
            obj.y = currentY
            itemsPlaced++
            currentX += obj.width
            console.log("currentX is at " + currentX)
        }

        console.log("LAYOUT DONE")
    }
}
