config = require './config.json'
gulp = require 'gulp'
sass = require 'gulp-sass'
jade = require 'gulp-jade'
jadeGlob = require 'gulp-jade-globbing'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'
mocha = require 'gulp-mocha'
connect = require 'gulp-connect'
exec = require('child_process').exec

server_process = null

gulp.task 'sass', ->
  gulp.src "#{config.sass.sourceDir}#{config.sass.compile}", {base: 'assets'}
    .pipe plumber()
    .pipe sass(config.sass.options)
    .pipe gulp.dest(config.sass.dest)

gulp.task 'jade', ->
  gulp.src "#{config.jade.sourceDir}#{config.jade.compile}", {base: 'assets'}
    .pipe plumber()
    .pipe jadeGlob()
    .pipe jade(config.jade.options)
    .pipe gulp.dest(config.jade.dest)

gulp.task 'coffee', ->
  gulp.src "#{config.coffee.sourceDir}#{config.coffee.compile}", {base: 'assets'}
    .pipe plumber()
    .pipe coffee(config.coffee.options)
    .pipe gulp.dest(config.coffee.dest)

gulp.task 'mocha', ->
  gulp.src "#{config.test.sourceDir}#{config.test.files}", {read: false}
    .pipe mocha(config.test.options)

gulp.task 'server', ->
  if config.server.custom
    server_process = exec "coffee #{config.server.serverFile}", {cwd: process.cwd(), env: process.env}, (error)->
    console.log 'server has started'
  else
    connect.server
      port: config.server.port
      root: config.server.sourceDir

gulp.task 'restart', ->
  if config.server.custom
    process.kill(server_process.pid)
    server_process = exec "coffee #{config.server.serverFile}", {cwd: process.cwd(), env: process.env}, (error)->
    console.log 'server has restarted'

gulp.task 'watch', ->
  gulp.watch "#{config.sass.sourceDir}#{config.sass.watch}", ['sass']
  gulp.watch "#{config.coffee.sourceDir}#{config.coffee.watch}", ['coffee', 'mocha']
  gulp.watch "#{config.test.sourceDir}#{config.test.files}", ['mocha']
  gulp.watch "#{config.jade.sourceDir}#{config.jade.watch}", ['jade']
  gulp.watch "#{config.server.watch}", ['restart']

gulp.task 'default', ['sass', 'jade', 'coffee', 'server', 'watch']