window.onload = ->
  canvas = document.getElementById('canvas_paintbrush_test')
  paint = new CanvasPaintbrush(canvas)

  paint
    .drawLine {x: 5, y: 5}, {x: 25, y: 220}, {strokeColor: 'green'}
    .drawRectBlock {x: 30, y: 5}, 20, 220, {fillColor: 'red'}
    .drawRectBox {x: 55, y: 5}, 20, 220, {strokeColor: 'green'}
    .drawRect {x: 85, y: 5}, 20, 220, {strokeColor: 'red', fillColor: 'green', lineWidth: 5}
    .drawPolyLine [{x: 125, y: 5}, {x: 140, y: 10}, {x: 130, y: 200}, {x: 135, y: 220}], {strokeColor: 'green'}
    .drawPolygon [{x: 170, y: 20}, {x: 190, y: 60}, {x: 180, y: 80}, {x: 160, y: 50}], {fillColor: 'red', strokeColor: 'green', lineWidth: 5}
    .drawBezier {x: 200, y: 10}, {x: 195, y: 40}, {x: 240, y: 40}, {x: 220, y: 80}, {strokeColor: 'red', lineWidth: 2}
    .drawQuadratic {x: 170, y: 100}, {x: 200, y: 280}, {x: 240, y: 130}, {strokeColor: 'green', lineWidth: 2}
    .drawSector {x: 310, y: 60}, 50, 0, Math.PI * 1.7, {strokeColor: 'green', fillColor: 'yellow', lineWidth: 10}
    .drawArc {x: 310, y: 170}, 50, Math.PI * 0.2, Math.PI * -.3, {strokeColor: 'red', lineWidth: 3}
    .drawCircle {x: 420, y: 60}, 50, {strokeColor: 'green', fillColor: 'yellow', lineWidth: 2}
    .drawCircle {x: 420, y: 170}, 50, {strokeColor: 'red', fillColor: 'transparent', lineWidth: 10}
    .drawText '去你大爷的', {x: 510, y: 20}, {rotate: Math.PI * 0.25, maxWidth: 90, strokeColor: 'red', fillColor: 'red'}
    .drawText '去你大爷的', {x: 510, y: 20}, {maxWidth: 90, strokeColor: 'green', fillColor: 'green'}

  svg = document.getElementById('svg_paintbrush_test')
  svg_paint = new SvgPaintbrush(svg)

  svg_paint
    .drawLine {x: 5, y: 5}, {x: 25, y: 220}, {strokeColor: 'green'}
    .drawRectBlock {x: 30, y: 5}, 20, 220, {fillColor: 'red'}
    .drawRectBox {x: 55, y: 5}, 20, 220, {strokeColor: 'green'}
    .drawRect {x: 85, y: 5}, 20, 220, {strokeColor: 'red', fillColor: 'green', lineWidth: 5}
    .drawPolyLine [{x: 125, y: 5}, {x: 140, y: 10}, {x: 130, y: 200}, {x: 135, y: 220}], {strokeColor: 'green'}
    .drawPolygon [{x: 170, y: 20}, {x: 190, y: 60}, {x: 180, y: 80}, {x: 160, y: 50}], {fillColor: 'red', strokeColor: 'green', lineWidth: 5}
    .drawBezier {x: 200, y: 10}, {x: 195, y: 40}, {x: 240, y: 40}, {x: 220, y: 80}, {strokeColor: 'red', lineWidth: 2}
    .drawQuadratic {x: 170, y: 100}, {x: 200, y: 280}, {x: 240, y: 130}, {strokeColor: 'green', lineWidth: 2}
    .drawSector {x: 310, y: 60}, 50, 0, Math.PI * 1.7, {strokeColor: 'green', fillColor: 'yellow', lineWidth: 10}
    .drawArc {x: 310, y: 170}, 50, Math.PI * 0.2, Math.PI * -.3, {strokeColor: 'red', lineWidth: 3}
    .drawCircle {x: 420, y: 60}, 50, {strokeColor: 'green', fillColor: 'yellow', lineWidth: 2}
    .drawCircle {x: 420, y: 170}, 50, {strokeColor: 'red', fillColor: 'transparent', lineWidth: 10}
    .drawText '去你大爷的', {x: 510, y: 20}, {rotate: Math.PI * 0.25, maxWidth: 90, strokeColor: 'red', fillColor: 'red'}
    .drawText '去你大爷的', {x: 510, y: 20}, {maxWidth: 90, strokeColor: 'green', fillColor: 'green'}
