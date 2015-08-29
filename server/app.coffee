'use strict'

express = require 'express'

app = express()

app.get '/', (req, res)->
  res.send('hello world')

module.exports = app
