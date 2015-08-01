'use strict'
http = require 'http'
server = http.createServer (req, res)->
  res.write('haha')
  res.end()

Server =
  start: (port, sourcePath)->
    server.sourcePath = sourcePath or './build'
    server.listen(port)
    console.log "server had start on #{port}"

module.exports = Server