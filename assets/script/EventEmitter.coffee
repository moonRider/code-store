# 给对象实例扩展事件驱动

class EventEmitter
  constructor: (obj)->
    @_data = obj
    @_addProperties()
    @_extendMethod()
    return @_data

  _addProperties: ->
    Object.defineProperty @_data, 'emitter', {
      writable: true
      value:
        _events: {}
      configurable: true
      enumerable: false
    }

  _extendMethod: ->
    event_methods =
      on: (event_type, handle, ctx)->
        return false if (event_type is undefined) or ((typeof event_type) isnt 'string') or (handle is undefined) or ((typeof handle) isnt 'function')
        ctx ?= @
        @_events[event_type] ?= []
        @_events[event_type].push
          func: handle
          ctx: ctx
        return true

      off: (event_type, handle)->
        @_events[event_type] ?= []
        if event_type is undefined
          @_events = {}
          return true
        if handle is undefined
          delete @_events[event_type]
          return true
        @_events[event_type] = @_events[event_type].filter (listener)->
          listener.func isnt handle
        return true

      trigger: (event_type, message)->
        _handles = if @_events? then @_events[event_type] else null
        return false unless _handles?
        for _handle in _handles
          _handle.func.call(_handle.ctx, message)
        return true

      fire: (event_type, message)->
        _handles = if @_events? then @_events[event_type] else null
        return false unless _handles?
        for _handle in _handles
          setTimeout ((handle)->
            return ->
              handle.func.call(handle.ctx, message)
          )(_handle), 0
        return true

    for k, v of event_methods
      @_data.emitter[k] = v


module.exports = EventEmitter if module?