# Svg 绘图工具

class SvgPaintbrush
  options:
    # 和CanvasPaintbrush一致
    fillColor: 'transparent'
    strokeColor: '#000000'
    lineWidth: 1.0

    fontSize: 11
    fontFamily: 'sans-serif'
    fontColor: '#333333'
    fontWeight: 1

  constructor: (ctx)->
    @ctx = ctx

  _createSvgElement: (tag)->
    document.createElementNS('http://www.w3.org/2000/svg', tag)

  _processFontOptions: (element, options)->
    _options = Object.assign {}, @options, options
    element.style.fontSize = _options.fontSize
    element.style.fontFamily = _options.fontFamily
    element.style.fill = _options.fontColor
    element.style.stroke = _options.fontColor
    element.style.strokeWidth = _options.fontWeight / 2

  _processShapeOptions: (element, options)->
    _options = Object.assign {}, @options, options
    element.style.stroke = _options.strokeColor
    element.style.fill = _options.fillColor
    element.style.strokeWidth = _options.lineWidth

  _processAngle: (startAngle, endAngle)->
    startAngle = startAngle - Math.floor(startAngle /(Math.PI * 2))* Math.PI * 2
    endAngle = endAngle - Math.floor(endAngle /(Math.PI * 2))* Math.PI * 2
    endAngle += Math.PI * 2 if startAngle > endAngle
    _result =
      startAngle: startAngle
      endAngle: endAngle

  _praseCoordinate: (centerpos, radius, angle)->
    _pos =
      x: centerpos.x + radius * Math.cos(angle)
      y: centerpos.y + radius * Math.sin(angle)

  _processOptions: (element, options)->
    _options = Object.assign {}, @options, options
    element.style.stroke = _options.strokeColor
    element.style.fill = _options.fillColor
    element.style.strokeWidth = _options.lineWidth
    element.style.fontSize = _options.fontSize
    element.style.fontFamily = _options.fontFamily

  _setAttributes: (element, attrs)->
    for k, v of attrs
      element.setAttribute k, v

  # Public method
  setGlobalOptions: (options)->
    Object.assign @options, options
    @

  drawLine: (startpos, endpos, options)->
    line = @_createSvgElement('path')
    line.setAttribute('d', "M#{startpos.x},#{startpos.y} L#{endpos.x},#{endpos.y}")
    @_processShapeOptions(line, options)
    @ctx.appendChild line
    @

  drawRect: (startpos, width, height, options)->
    rect = @_createSvgElement('rect')
    @_processShapeOptions(rect, options)
    @_setAttributes rect, {x: startpos.x, y: startpos.y, width: width, height: height}
    @ctx.appendChild rect
    @

  drawRectBlock: (startpos, width, height, options)->
    options.lineWidth = 0
    @drawRect(startpos, width, height, options)

  drawRectBox: (startpos, width, height, options)->
    options.fillColor = 'transparent'
    @drawRect(startpos, width, height, options)

  drawPolyLine: (points, options)->
    return @ if points.length < 2
    path = @_createSvgElement('path')
    directive = "M#{points[0].x},#{points[0].y}"
    for i in [1...points.length]
      directive += " L#{points[i].x},#{points[i].y}"
    path.setAttribute 'd', directive
    @_processShapeOptions(path, options)
    @ctx.appendChild path
    @

  drawPolygon: (points, options)->
    return @ if points.length < 3
    path = @_createSvgElement('path')
    directive = "M#{points[0].x},#{points[0].y}"
    for i in [1...points.length]
      directive += " L#{points[i].x},#{points[i].y}"
    path.setAttribute 'd', "#{directive} Z"
    @_processOptions(path, options)
    @ctx.appendChild path
    @

  drawBezier: (startpos, ctp1, ctp2, endpos, options)->
    path = @_createSvgElement('path')
    path.setAttribute 'd', "M#{startpos.x},#{startpos.y} C#{ctp1.x},#{ctp1.y} #{ctp2.x},#{ctp2.y} #{endpos.x},#{endpos.y}"
    @_processShapeOptions(path, options)
    @ctx.appendChild path
    @

  drawQuadratic: (startpos, ctpos, endpos, options)->
    path = @_createSvgElement('path')
    path.setAttribute 'd', "M#{startpos.x},#{startpos.y} Q#{ctpos.x},#{ctpos.y} #{endpos.x},#{endpos.y}"
    @_processShapeOptions(path, options)
    @ctx.appendChild path
    @

  drawSector: (centerpos, radius, startAngle, endAngle, options)->
    angles = @_processAngle(startAngle, endAngle)
    startpos = @_praseCoordinate(centerpos, radius, angles.startAngle)
    endpos = @_praseCoordinate(centerpos, radius, angles.endAngle)
    LargeArcFlag = if (angles.endAngle - angles.startAngle > Math.PI) then 1 else 0
    path = @_createSvgElement('path')
    path.setAttribute 'd', "M#{centerpos.x},#{centerpos.y} L#{startpos.x},#{startpos.y} A#{radius},#{radius} 0 #{LargeArcFlag} 1 #{endpos.x},#{endpos.y} Z"
    @_processShapeOptions(path, options)
    @ctx.appendChild path
    @

  drawArc: (centerpos, radius, startAngle, endAngle, options)->
    options.fillColor = 'transparent'
    angles = @_processAngle(startAngle, endAngle)
    startpos = @_praseCoordinate(centerpos, radius, angles.startAngle)
    endpos = @_praseCoordinate(centerpos, radius, angles.endAngle)
    LargeArcFlag = if (angles.endAngle - angles.startAngle > Math.PI) then 1 else 0
    path = @_createSvgElement('path')
    path.setAttribute 'd', "M#{startpos.x},#{startpos.y} A#{radius},#{radius} 0 #{LargeArcFlag} 1 #{endpos.x},#{endpos.y}"
    @_processShapeOptions(path, options)
    @ctx.appendChild path
    @

  drawCircle: (centerpos, radius, options)->
    circle = @_createSvgElement('circle')
    @_setAttributes circle, {cx: centerpos.x, cy: centerpos.y, r: radius}
    @_processShapeOptions(circle, options)
    @ctx.appendChild circle
    @

  drawText: (text_str, pos, options)->
    text = @_createSvgElement('text')
    @_setAttributes text, {x: pos.x, y: pos.y}
    text.setAttribute 'transform', "rotate(#{options.rotate} #{pos.x},#{pos.y})" if options.rotate?
    @_processFontOptions(text, options)
    text.textContent = text_str
    @ctx.appendChild text
    @

