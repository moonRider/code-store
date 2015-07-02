require 'should'
Shims = require '../assets/script/EsShim.coffee'

Shims.init()

describe 'Shims', ->
  describe 'Object.assign(target, sources)', ->
    target =
      a: 1
      b: 2

    source1 =
      a: 11
      c: 33

    source2 =
      b: 222
      c: 333

    merged = Object.assign(target, source1)

    it 'should not create an new object', ->
      merged.should.be.eql(target)
    it 'should create new attribute if attribute not exist in target', ->
      merged.c.should.be.eql(source1.c)
    it 'should overflow attribute if attribute exist in target', ->
      merged.a.should.be.eql(source1.a)
    it 'should has higher priority if the source farther away the target', ->
      merged = Object.assign(target, source1, source2)
      merged.c.should.be.eql(source2.c)

  describe 'number.toPercentage()', ->
    number = 0.1415926
    percentaged = number.toPercentage(2)

    it 'should return a string', ->
      (typeof percentaged is 'string').should.be.true
      percentaged.should.be.eql('14.16%')
    it 'should be not enumerable', ->
      number.propertyIsEnumerable('toPercentage').should.be.false