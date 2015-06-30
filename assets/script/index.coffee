window.onload = ->
  canvas = document.getElementById('canvas_paintbrush_test').getContext('2d')
  paint = new CanvasPaintbrush(canvas)
