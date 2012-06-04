/*
 * in memory of Gary 'lcuk' Birkett and liqbase.
 */

import QtQuick 2.0
import ".."

Widget {
    Canvas {
        id: canvas
        smooth: false
        anchors.fill: parent
        width: parent.width
        height: parent.height

        onHeightChanged: requestPaint()
        onWidthChanged: requestPaint()

        property var strokes: []
        property var currentStroke: -1

        onPaint: {
            //console.log("Drawing " + canvas.strokes.length + " strokes")
            var ctx = canvas.getContext('2d');
            ctx.save();
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            ctx.rotate(canvas.rotate);

            for (var i = 0; i < canvas.strokes.length; ++i) {
                // ignore single points for now
                if (canvas.strokes[i].length == 1)
                    continue

                ctx.beginPath()
                ctx.moveTo(width * canvas.strokes[i][0].x, height * canvas.strokes[i][0].y)

                for (var j = 1; j < canvas.strokes[i].length; ++j) {
                    ctx.lineTo(width * canvas.strokes[i][j].x, height * canvas.strokes[i][j].y)
                }

                ctx.stroke()
            }

            ctx.restore()
            //console.log("Drawing done")
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                var xf = mouseX / width
                var yf = mouseY / height

                canvas.strokes.push([])
                canvas.currentStroke++
                canvas.strokes[canvas.currentStroke].push({ x: xf, y: yf })
                canvas.markDirty(0, 0, canvas.width, canvas.height)
                canvas.requestPaint()
            }

            onPositionChanged: {
                var xf = mouseX / width
                var yf = mouseY / height

                canvas.strokes[canvas.currentStroke].push({ x: xf, y: yf })
                canvas.markDirty(0, 0, canvas.width, canvas.height)
                canvas.requestPaint()
            }

            onReleased: {
                canvas.requestPaint()
            }
        }
    }
}
