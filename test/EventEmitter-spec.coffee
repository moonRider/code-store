require 'should'
EventEmitter = require '../assets/script/EventEmitter.coffee'

describe 'EventEmitter', ->
  _data =
    name: '小红'
    age: 18
  a = (msg)->
    return msg or 'a'
  b = ->
    return 'b'

  describe '.new()', ->
    t_emitter = new EventEmitter _data

    it 'should has "emitter" property', ->
      t_emitter.should.has.property('emitter')
    it 'could not create a new object', ->
      t_emitter.should.be.eql _data
    it 'should be not enumerable', ->
      t_emitter.propertyIsEnumerable('emitter').should.be.false

    describe '.emitter', ->
      emitter = t_emitter.emitter

      beforeEach ->
        emitter.off()
        delete emitter._test

      it 'should has "_events" property', ->
        emitter.should.has.property('_events')
      it 'should has "on" method', ->
        emitter.should.has.property('on') and (typeof emitter.on).should.be.eql('function')
      it 'should has "off" method', ->
        emitter.should.has.property('off') and (typeof emitter.off).should.be.eql('function')
      it 'should has "trigger" method', ->
        emitter.should.has.property('trigger') and (typeof emitter.trigger).should.be.eql('function')
      it 'should has "fire" method', ->
        emitter.should.has.property('fire') and (typeof emitter.fire).should.be.eql('function')

      describe '.on()', ->
        beforeEach ->
          emitter.on 'a', a
          emitter.on 'b', b

        it 'should be an increase of 1 in "_events" property', ->
          emitter._events.a.length.should.be.eql(1)
          emitter.on 'a', b
          emitter._events.a.length.should.be.eql(2)
        it 'should get false if arguments[1] is not a function', ->
          emitter.on('a', 90).should.be.false
        it 'should get false if arguments[1] is undefined', ->
          emitter.on('a').should.be.false
        it 'should get false if arguments[0] is undefined', ->
          emitter.on().should.be.false
        it 'should get false if arguments[0] is not a string', ->
          emitter.on(34).should.be.false

      describe '.off()', ->
        beforeEach ->
          emitter.on 'a', a
          emitter.on 'b', b

        it 'should clear all property in "_events" without any input', ->
          emitter.off()
          emitter._events.should.be.empty
        it 'should delete current property in "_events" without second argument', ->
          emitter.off('a')
          emitter._events.should.not.has.property('a')
        it 'should remove the handle which exist in "_events.current_property"', ->
          emitter.on 'a', b
          emitter._events.a.length.should.be.eql(2)
          emitter.off 'a', a
          emitter._events.a.length.should.be.eql(1)
          emitter._events.b.length.should.be.eql(1)
          emitter.off 'b', b
          emitter._events.b.length.should.be.eql(0)
        it 'should do nothing if handle do not regist by on method', ->
          emitter.off 'a', b
          emitter._events.a.length.should.be.eql(1)

      describe '.trigger()', ->
        beforeEach ->
          emitter.on 'trigger', (msg)->
            emitter._test =
              execed: true
              msg: msg
        afterEach ->
          delete emitter._test

        it 'should exec the bundled method immediately', ->
          emitter.trigger('trigger')
          emitter._test.execed.should.be.true
        it 'should transfer message to bundled method', ->
          message =
            haha: 1
          emitter.trigger('trigger', message)
          emitter._test.msg.should.be.eql(message)

      describe '.fire()', ->
        it 'should be an asynchronous method', ->
          emitter.on 'fire', (msg)->
            emitter._test =
              execed: true
              msg: msg
          emitter.fire('fire')
          emitter.should.not.has.property('_test')

        it 'should exec the bundled method in next eventLoop', (done)->
          emitter.on 'fire', (msg)->
            emitter._test =
              execed: true
              msg: msg
            done()
          emitter.fire('fire')

        it 'should exec all the bundled methods not only the last one', (done)->
          count = 0
          emitter.on 'fire', (msg)->
            emitter._test =
              execed: true
              msg: msg
              count: count + 1
          emitter.on 'fire', (msg2)->
            emitter._test.count += 1
            emitter._test.count.should.be.eql(2)
            done()
          emitter.fire('fire')
