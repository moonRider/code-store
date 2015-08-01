'use strict'
Shims =
  init: ->
    @assign()
    @percentage()

  assign: ->
    unless Object.assign
      Object.defineProperty Object, 'assign', {
        enumerable: false
        configurable: true
        writable: true
        value: (target)->
          unless target?
            throw new TypeError('Cannot convert first argument to object')

          to = Object(target)
          for i in [1..arguments.length - 1] by 1
            nextSource = arguments[i]
            unless nextSource?
              continue
            keysArray = Object.keys Object(nextSource)
            for j in [0..keysArray.length-1] by 1
              nextKey = keysArray[j]
              desc = Object.getOwnPropertyDescriptor(nextSource, nextKey)
              if desc isnt undefined and desc.enumerable
                to[nextKey] = nextSource[nextKey]
          to
      }

  percentage: ->
    unless Number.prototype.toPercentage
      Object.defineProperty Number.prototype, 'toPercentage', {
        enumerable: false
        writable: true
        configurable: true
        value: (int_number=1)->
          return (parseFloat(@) * 100).toFixed(int_number) + '%'
      }

Shims.init()

module.exports = Shims if module?