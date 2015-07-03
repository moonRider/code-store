# canvas 绘图工具

class CanvasPaintbrush
  options:
    ### 图形设置
      # 填充颜色fillColor --任意有效的CSS颜色值，默认transparent
      # 线条颜色strokeColor --任意有效的CSS颜色值，默认黑色
      # 线条宽度LineWidth --无单位数字，默认1
    ###
    fillColor: 'transparent'
    strokeColor: '#000000'
    lineWidth: 1.0

    ### 字体设置
      # 字体大小fontSize --无单位整数字，默认11
      # 字体fontFamily --任意有效的CSS字体，默认sans-serif
      # 字体颜色fontColor --任意有效的CSS颜色值，默认#333333
      # 字体粗细fontWeight --[1|2]，1表示细体，2表示粗体，默认1
    ###
    fontSize: 11
    fontFamily: 'sans-serif'
    fontColor: '#333333'
    fontWeight: 1
    maxWidth: 1000

  constructor: (element)->
    @ctx = element.getContext('2d')
    @_processSize(element)

  _processSize: (element)->
    css_styles = document.defaultView.getComputedStyle(element)
    _width = parseInt(css_styles.getPropertyValue('Width')) or element.width or 300
    _height = parseInt(css_styles.getPropertyValue('Height')) or element.height or 150
    element.width = _width * 2
    element.height = _height * 2

  _processFontOptions: (options)->
    _options = Object.assign {}, @options, options
    @ctx.font = "#{_options.fontSize * 2}px #{_options.fontFamily}"
    @ctx.fillStyle = _options.fontColor
    @ctx.strokeStyle = _options.fontColor
    @ctx.lineWidth = _options.fontWeight
    _options

  _processShapeOptions: (options)->
    _options = Object.assign {}, @options, options
    @ctx.fillStyle = _options.fillColor
    @ctx.strokeStyle = _options.strokeColor
    @ctx.lineWidth = _options.lineWidth * 2
    _options

  _processOptions: (options)->
    _options = Object.assign {}, @options, options
    @ctx.fillStyle = _options.fillColor
    @ctx.strokeStyle = _options.strokeColor
    @ctx.lineWidth = _options.lineWidth * 2
    @ctx.font = "#{_options.fontSize * 2}px sans-serif"

  # reduce startAngle into [0,2PI)，and be sure that endAngle - startAngle belongs to [0, 2PI)
  _processAngle: (startAngle, endAngle)->
    startAngle = startAngle - Math.floor(startAngle /(Math.PI * 2))* Math.PI * 2
    endAngle = endAngle - Math.floor(endAngle /(Math.PI * 2))* Math.PI * 2
    endAngle += Math.PI * 2 if startAngle > endAngle
    _result =
      startAngle: startAngle
      endAngle: endAngle

  # Public method
  drawLine: (startpos, endpos, options)->
    @_processShapeOptions(options)
    @ctx.beginPath()
    @ctx.moveTo(startpos.x * 2, startpos.y * 2)
    @ctx.lineTo(endpos.x * 2, endpos.y * 2)
    @ctx.stroke()
    @

  drawRect: (startpos, width, height, options)->
    border_width = parseInt(options.lineWidth)
    @_processShapeOptions(options)
    @ctx.strokeRect(startpos.x * 2, startpos.y * 2, width * 2, height * 2)
    @ctx.fillRect(startpos.x * 2 + border_width, startpos.y * 2 + border_width, (width - border_width) * 2, (height - border_width) * 2)
    @

  drawRectBlock: (startpos, width, height, options)->
    @_processShapeOptions(options)
    @ctx.fillRect(startpos.x * 2, startpos.y * 2, width * 2, height * 2)
    @

  drawRectBox: (startpos, width, height, options)->
    @_processShapeOptions(options)
    @ctx.strokeRect(startpos.x * 2, startpos.y * 2, width * 2, height * 2)
    @

  drawPolyLine: (points, options)->
    return @ if points.length < 2
    @ctx.beginPath()
    @_processShapeOptions(options)
    @ctx.moveTo points[0].x * 2, points[0].y * 2
    for i in [1...points.length]
      @ctx.lineTo points[i].x * 2, points[i].y * 2
    @ctx.stroke()
    @

  drawPolygon: (points, options)->
    return @ if points.length < 3
    @ctx.beginPath()
    @_processShapeOptions(options)
    @ctx.moveTo points[0].x * 2, points[0].y * 2
    for i in [1...points.length]
      @ctx.lineTo points[i].x * 2, points[i].y * 2
    @ctx.closePath()
    @ctx.fill()
    @ctx.stroke()
    @

  drawBezier: (startpos, ctp1, ctp2, endpos, options)->
    @ctx.beginPath()
    @_processShapeOptions(options)
    @ctx.moveTo startpos.x * 2, startpos.y * 2
    @ctx.bezierCurveTo ctp1.x * 2, ctp1.y * 2, ctp2.x * 2, ctp2.y * 2, endpos.x * 2, endpos.y * 2
    @ctx.stroke()
    @

  drawQuadratic: (startpos, ctpos, endpos, options)->
    @ctx.beginPath()
    @_processShapeOptions(options)
    @ctx.moveTo startpos.x * 2, startpos.y * 2
    @ctx.quadraticCurveTo ctpos.x * 2, ctpos.y * 2, endpos.x * 2, endpos.y *2
    @ctx.stroke()
    @

  drawSector: (centerpos, radius, startAngle, endAngle, options)->
    @_processShapeOptions(options)
    angles = @_processAngle(startAngle, endAngle)
    @ctx.beginPath()
    @ctx.arc centerpos.x * 2, centerpos.y * 2, radius * 2, angles.startAngle, angles.endAngle, false
    @ctx.lineTo centerpos.x * 2, centerpos.y * 2
    @ctx.closePath()
    @ctx.fill()
    @ctx.stroke() unless options.lineWidth is 0
    @

  drawArc: (centerpos, radius, startAngle, endAngle, options)->
    @_processShapeOptions(options)
    angles = @_processAngle(startAngle, endAngle)
    @ctx.beginPath()
    @ctx.arc centerpos.x * 2, centerpos.y * 2, radius * 2, angles.startAngle, angles.endAngle, false
    @ctx.stroke()
    @

  drawCircle: (centerpos, radius, options)->
    @_processShapeOptions(options)
    @ctx.beginPath()
    @ctx.arc centerpos.x * 2, centerpos.y * 2, radius * 2, 0, Math.PI * 2, false
    @ctx.fill()
    @ctx.stroke() unless options.lineWidth is 0
    @

  drawText: (text, pos, options)->
    _options = @_processFontOptions(options)
    if options.rotate?
      @ctx.save()
      @ctx.translate pos.x * 2, pos.y * 2
      @ctx.rotate(options.rotate * Math.PI / 180)
      @ctx.fillText text, 0, 0, _options.maxWidth * 2
      @ctx.strokeText text, 0, 0, _options.maxWidth * 2
      @ctx.restore()
    else
      @ctx.fillText text, pos.x * 2, pos.y * 2, _options.maxWidth * 2
      @ctx.strokeText text, pos.x * 2, pos.y * 2, _options.maxWidth * 2
    @
