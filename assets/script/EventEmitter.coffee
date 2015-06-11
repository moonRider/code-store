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

    for k, v of event_methods
      @_data.emitter[k] = v


module.exports = EventEmitter