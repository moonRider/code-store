# canvas 绘图工具

class CanvasPaintbrush
  options:
    # 填充颜色
    fillColor: '#ffffff'
    # 轮廓颜色
    strokeColor: '#000000'
    # 透明度 [0~1]
    alpha: 1
    # 线宽 [number]
    lineWidth: 2.0
    # 线段端点的样式 [butt|round|square]
    linecap: 'butt'
    # 线段与线段链接处的样式 [round|bevel|miter]
    linejoin: 'round'

  constructor: (ctx)->
    @ctx = ctx

  drawLine: (startpos, endpos, options)->
