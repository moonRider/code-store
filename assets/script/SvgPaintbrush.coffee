# Svg 绘图工具
class SvgPaintbrush
  options:
    # 填充颜色
    fillColor: 'transparent'
    # 轮廓颜色
    strokeColor: '#000000'
    # 线宽 [number]
    lineWidth: 1.0

  constructor: (ctx)->
    @ctx = ctx

  _createSvgElement: (tag)->
    document.createElementNS('http://www.w3.org/2000/svg', tag)

  _processOptions: (element, options)->
    _options = Object.assign {}, @options, options
    element.setAttribute('stroke', _options.strokeColor)
    element.setAttribute('fill', _options.fillColor)
    element.setAttribute('stroke-width', _options.lineWidth)

  drawLine: (startpos, endpos, options)->
    line = @_createSvgElement('path')
    line.setAttribute('d', "M#{startpos.x},#{startpos.y} L#{endpos.x},#{endpos.y}")
    @_processOptions(line, options)
    @ctx.appendChild line
    @

  drawRect: (startpos, width, height, options)->
    rect = @_createSvgElement('rect')
    rect.setAttribute 'x', startpos.x
    rect.setAttribute 'y', startpos.y
    rect.setAttribute 'width', width
    rect.setAttribute 'height', height
    @_processOptions(rect, options)
    @ctx.appendChild rect
    @

  drawRectBlock: (startpos, width, height, options)->
    options.strokeColor = 'transparent'
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
    @_processOptions(path, options)
    @ctx.appendChild path
    @

  drawPolygon: (points, options)->
    return @ if points.length < 3
    path = @_createSvgElement('path')
    directive = "M#{points[0].x},#{points[0].y}"
    for i in [1...points.length]
      directive += " L#{points[i].x},#{points[i].y}"
    directive += ' Z'
    path.setAttribute 'd', directive
    @_processOptions(path, options)
    @ctx.appendChild path
    @

  drawBezier: (startpos, ctp1, ctp2, endpos, options)->
    path = @_createSvgElement('path')
    path.setAttribute 'd', "M#{startpos.x},#{startpos.y} C#{ctp1.x},#{ctp1.y} #{ctp2.x},#{ctp2.y} #{endpos.x},#{endpos.y}"
    @_processOptions(path, options)
    @ctx.appendChild path
    @

  drawQuadratic: (startpos, ctpos, endpos, options)->
    path = @_createSvgElement('path')
    path.setAttribute 'd', "M#{startpos.x},#{startpos.y} Q#{ctpos.x},#{ctpos.y} #{endpos.x},#{endpos.y}"
    @_processOptions(path, options)
    @ctx.appendChild path
    @
