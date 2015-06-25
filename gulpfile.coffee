config = require './config.json'
gulp = require 'gulp'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'
mocha = require 'gulp-mocha'

gulp.task 'sass', ->
  gulp.src "#{config.sass.sourceDir}#{config.sass.compile}", {base: 'assets'}
    .pipe plumber()
    .pipe sass(config.sass.options)
    .pipe gulp.dest(config.sass.dest)

gulp.task 'coffee', ->
  gulp.src "#{config.coffee.sourceDir}#{config.coffee.compile}", {base: 'assets'}
    .pipe plumber()
    .pipe coffee(config.coffee.options)
    .pipe gulp.dest(config.coffee.dest)

gulp.task 'mocha', ->
  gulp.src "#{config.test.sourceDir}#{config.test.files}", {read: false}
    .pipe mocha(config.test.options)

gulp.task 'watch', ->
  gulp.watch "#{config.sass.sourceDir}#{config.sass.watch}", ['sass']
  gulp.watch "#{config.coffee.sourceDir}#{config.coffee.watch}", ['coffee', 'mocha']
  gulp.watch "#{config.test.sourceDir}#{config.test.files}", ['mocha']


gulp.task 'default', ['sass', 'coffee', 'watch']