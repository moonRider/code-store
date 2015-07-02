window.onload = ->
  canvas = document.getElementById('canvas_paintbrush_test').getContext('2d')
  paint = new CanvasPaintbrush(canvas)

  paint.drawLine {x: 5, y: 5}, {x: 25, y: 295}, {strokeColor: 'green'}

  svg = document.getElementById('svg_paintbrush_test')
  svg_paint = new SvgPaintbrush(svg)

  svg_paint.drawLine {x: 5, y: 5}, {x: 25, y: 295}, {strokeColor: 'green'}
