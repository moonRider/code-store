'use strict'
path = require 'path'
send = require 'send'
http = require 'http'
url = require 'url'

static_exts = ['.ico', '.gif', '.png', '.jpeg', '.jpg', '.html', '.htm', '.css', '.js', '.pdf', '.txt', '.svg', '.swf', '.mp4', '.mp3', '.wav', '.wma', '.wmv', '.xml']

dynamic_exts = ['.json', '.jade', '.scss', '.coffee', '.slim']

Router = (request, response)->
  url_obj = url.parse request.url
  path_obj = path.parse url_obj.pathname
  if static_exts.indexOf(path_obj.ext) isnt -1
    send(request, url_obj.pathname, {root: process.cwd()+'/build'})
    .on 'error', (e)->
      response.end('file not found')
    .pipe(response)
  else
    req = http.request
      port: 5000
      headers: request.headers
    , (res)->
      response.writeHead(200, res.headers)
      res.pipe(response)
    req.on 'error', (e)->
      response.end 'not found'
    req.end()

module.exports = Router