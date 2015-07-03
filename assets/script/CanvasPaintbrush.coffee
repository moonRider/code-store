# canvas 绘图工具

class CanvasPaintbrush
  options:
    # 填充颜色
    fillColor: 'transparent'
    # 轮廓颜色
    strokeColor: '#000000'
    # 线宽 [number]
    lineWidth: 1.0
    # 线段端点的样式 [butt|round|square]
    lineCap: 'butt'
    # 线段与线段链接处的样式 [round|bevel|miter]
    lineJoin: 'mitter'

  constructor: (ctx)->
    @ctx = ctx

  _processOptions: (options)->
    _options = Object.assign {}, @options, options
    @ctx.fillStyle = _options.fillColor
    @ctx.strokeStyle = _options.strokeColor
    @ctx.lineWidth = _options.lineWidth * 2
    @ctx.lineCap = _options.lineCap
    @ctx.lineJoin = _options.lineJoin

  drawLine: (startpos, endpos, options)->
    @ctx.beginPath()
    @ctx.moveTo(startpos.x * 2, startpos.y * 2)
    @_processOptions(options)
    @ctx.lineTo(endpos.x * 2, endpos.y * 2)
    @ctx.stroke()
    @

  drawRect: (startpos, width, height, options)->
    border_width = parseInt(options.lineWidth)
    options = @_processOptions(options)
    @ctx.strokeRect(startpos.x * 2, startpos.y * 2, width * 2, height * 2)
    @ctx.fillRect(startpos.x * 2 + border_width, startpos.y * 2 + border_width, (width - border_width) * 2, (height - border_width) * 2)
    @

  drawRectBlock: (startpos, width, height, options)->
    @_processOptions(options)
    @ctx.fillRect(startpos.x * 2, startpos.y * 2, width * 2, height * 2)
    @

  drawRectBox: (startpos, width, height, options)->
    @_processOptions(options)
    @ctx.strokeRect(startpos.x * 2, startpos.y * 2, width * 2, height * 2)
    @

  drawPolyLine: (points, options)->
    return @ if points.length < 2
    @ctx.beginPath()
    @_processOptions(options)
    @ctx.moveTo points[0].x * 2, points[0].y * 2
    for i in [1...points.length]
      @ctx.lineTo points[i].x * 2, points[i].y * 2
    @ctx.stroke()
    @

  drawPolygon: (points, options)->
    return @ if points.length < 3
    @ctx.beginPath()
    @_processOptions(options)
    @ctx.moveTo points[0].x * 2, points[0].y * 2
    for i in [1...points.length]
      @ctx.lineTo points[i].x * 2, points[i].y * 2
    @ctx.closePath()
    @ctx.fill()
    @ctx.stroke()
    @

  drawBezier: (startpos, ctp1, ctp2, endpos, options)->
    @ctx.beginPath()
    @_processOptions(options)
    @ctx.moveTo startpos.x * 2, startpos.y * 2
    @ctx.bezierCurveTo ctp1.x * 2, ctp1.y * 2, ctp2.x * 2, ctp2.y * 2, endpos.x * 2, endpos.y * 2
    @ctx.stroke()
    @

  drawQuadratic: (startpos, ctpos, endpos, options)->
    @ctx.beginPath()
    @_processOptions(options)
    @ctx.moveTo startpos.x * 2, startpos.y * 2
    @ctx.quadraticCurveTo ctpos.x * 2, ctpos.y * 2, endpos.x * 2, endpos.y *2
    @ctx.stroke()
    @
