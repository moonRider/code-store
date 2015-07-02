# Svg 绘图工具
class SvgPaintbrush
  options:
    # 填充颜色
    fillColor: '#ffffff'
    # 轮廓颜色
    strokeColor: '#000000'
    # 线宽 [number]
    lineWidth: 2.0

  constructor: (ctx)->
    @ctx = ctx

  _processOptions: (element, options)->
    _options = Object.assign {}, @options, options
    element.setAttribute('stroke', _options.strokeColor)
    element.setAttribute('fill', _options.fillColor)
    element.setAttribute('strokeWidth', _options.lineWidth)

  drawLine: (startpos, endpos, options)->
    line = document.createElementNS('http://www.w3.org/2000/svg','path')
    line.setAttribute('d', "M#{startpos.x},#{startpos.y} L#{endpos.x},#{endpos.y}")
    @_processOptions(line, options)
    @ctx.appendChild line
    @
