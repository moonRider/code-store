window.onload = ->
  canvas = document.getElementById('canvas_paintbrush_test').getContext('2d')
  paint = new CanvasPaintbrush(canvas)

  paint.drawLine {x: 10, y: 10}, {x: 50, y: 590}, {strokeColor: 'green'}