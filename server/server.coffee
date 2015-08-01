'use strict'
http = require 'http'

route = (request, response)->
  console.log 'routing'
  req = http.request
    port: '5000'
  , (res)->
    res.on 'data', (chunk)->
      response.end(chunk)

  req.on 'error', (e)->
    console.log e.message
    response.end('not found')

  req.end()

server = http.createServer (req, res)->
  route(req, res)

Server =
  start: (port, sourcePath)->
    server.sourcePath = sourcePath or './build'
    server.listen(port)
    console.log "server had start on #{port}"

module.exports = Server