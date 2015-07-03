window.onload = ->
  canvas = document.getElementById('canvas_paintbrush_test')
  paint = new CanvasPaintbrush(canvas)

  drawTask = (painter)->
    painter
      .drawLine {x: 5, y: 5}, {x: 45, y: 15}, {strokeColor: 'rgba(0, 100, 0, 0.8)', lineWidth: 3}
      .drawRect {x: 5, y: 20}, 40, 20, {fillColor: 'rgba(23, 189, 26, 0.8)', strokeColor: 'green', lineWidth: 5}
      .drawRectBlock {x: 5, y: 50}, 40, 20, {fillColor: 'rgba(98, 34, 244, 0.8)', strokeColor: 'red', lineWidth: 2}
      .drawRectBox {x: 5, y: 80}, 40, 20, {strokeColor: 'rgba(60, 80, 120, 0.8)', fillColor: 'green', lineWidth: 3}
      .drawPolyLine [{x: 5, y: 110}, {x: 8, y: 135}, {x: 24, y: 120}, {x: 29, y: 136}, {x: 50, y: 120}], {strokeColor: 'rgba(120, 80, 60, 0.8)', lineWidth: 2}
      .drawPolygon [{x: 60, y: 40}, {x: 80, y: 5}, {x: 120, y: 45}, {x: 125, y: 70}, {x: 110, y: 60}, {x: 70, y: 54}], {fillColor: '#da6d4e', strokeColor: '#73a8c7'}
      .drawBezier {x: 60, y: 120}, {x: 70, y: 60}, {x: 95, y: 110}, {x: 120, y: 90}, {strokeColor: 'green', lineWidth: 2}
      .drawQuadratic {x: 10, y: 180}, {x: 50, y: 220}, {x: 118, y: 130}, {strokeColor: '#73a8c7', lineWidth: 2}
      .drawSector {x: 200, y: 70}, 50, Math.PI * -0.7, Math.PI * 4.8, {fillColor: '#73a8c7', lineWidth: 0}
      .drawArc {x: 200, y: 200}, 50, Math.PI * -0.2, Math.PI * 3, {fillColor: 'red', strokeColor: 'green', lineWidth: 2}
      .drawCircle {x: 320, y: 70}, 50, {strokeColor: '#da6d4e', fillColor: '#73a8c7', lineWidth: 0}
      .drawCircle {x: 320, y: 200}, 50, {strokeColor: '#da6d4e', fillColor: '#73a8c7', lineWidth: 10}
      .drawText '去你大爷的', {x: 400, y: 100}, {fontColor: 'green', fontSize: 16, fontWeight: 2}
      .drawText '去你大爷的', {x: 400, y: 200}, {fontColor: '#73a8c7', rotate: 45, maxWidth: 60}

  drawTask(paint)

  svg = document.getElementById('svg_paintbrush_test')
  svg_paint = new SvgPaintbrush(svg)

  drawTask(svg_paint)
