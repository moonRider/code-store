require 'should'
EventEmitter = require '../assets/script/EventEmitter.coffee'

describe 'EventEmitter', ->
  _data =
    name: '小红'
    age: 18

  t_emitter = new EventEmitter _data

  describe 'instance', ->
    it 'should has "emitter" property', ->
      t_emitter.should.has.property('emitter')
    it 'could not create a new object', ->
      t_emitter.should.be.eql _data

    describe 'emitter property', ->
      emitter = t_emitter.emitter
      it 'should has "_events" property', ->
        emitter.should.has.property('_events')
      it 'should has "on" method', ->
        emitter.should.has.property('on') and (typeof emitter.on).should.be.eql('function')
      it 'should has "off" method', ->
        emitter.should.has.property('off') and (typeof emitter.off).should.be.eql('function')

      describe '"on" method', ->
        it 'should be an increase of 1 in "_events" property', ->
          emitter.on 'hehe', ->
          emitter._events.hehe.length.should.be.eql(1)
          emitter.on 'hehe', ->
            console.log 'hehe'
          , emitter
          emitter._events.hehe.length.should.be.eql(2)
        it 'should get false if arguments[1] is not a function', ->
          emitter.on('a', 90).should.be.false
        it 'should get false if arguments[1] is undefined', ->
          emitter.on('a').should.be.false
        it 'should get false if arguments[0] is undefined', ->
          emitter.on().should.be.false
        it 'should get false if arguments[0] is not a string', ->
          emitter.on(34).should.be.false

      describe '"off" method', ->
        it 'should clear all property in "_events" without any input', ->
          emitter.on 'a', ->
          emitter.on 'b', ->
          emitter.off()
          emitter._events.should.be.empty
        it 'should delete current property in "_events" without second argument', ->
          emitter.on 'a', ->
          emitter.off('a')
          emitter._events.should.not.has.property('a')
