'use strict'
http = require 'http'
router = require './router.coffee'

server = http.createServer (req, res)->
  router(req, res)

Server =
  start: (port, sourcePath)->
    server.sourcePath = sourcePath or './build'
    server.listen(port)
    console.log "server had start on #{port}"
  stop: ->
    server.close()

module.exports = Server