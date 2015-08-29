'use strict'
app = require './app.coffee'
http = require 'http'
server_config = require('../config.json').server

_servers = {}

http.createServer(app).listen server_config.port
