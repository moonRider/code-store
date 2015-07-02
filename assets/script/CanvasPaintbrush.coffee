# canvas 绘图工具

class CanvasPaintbrush
  options:
    # 填充颜色
    fillColor: '#ffffff'
    # 轮廓颜色
    strokeColor: '#000000'
    # 线宽 [number]
    lineWidth: 2.0
    # 线段端点的样式 [butt|round|square]
    lineCap: 'butt'
    # 线段与线段链接处的样式 [round|bevel|miter]
    lineJoin: 'round'

  constructor: (ctx)->
    @ctx = ctx

  _processOptions: (options)->
    _options = Object.assign {}, @options, options
    @ctx.fillStyle = _options.fillColor
    @ctx.strokeStyle = _options.strokeColor
    @ctx.lineWidth = _options.lineWidth
    @ctx.lineCap = _options.lineCap
    @ctx.lineJoin = _options.lineJoin
    @

  drawLine: (startpos, endpos, options)->
    @ctx.beginPath()
    @ctx.moveTo(startpos.x, startpos.y)
    @_processOptions(options)
    @ctx.lineTo(endpos.x, endpos.y)
    @ctx.stroke()
    @
