var config = require('./config.json');
var gulp = require('gulp');
var sass = require('gulp-sass');
var coffee = require('gulp-coffee');
var plumber = require('gulp-plumber');

gulp.task('sass', function(){
  return gulp
    .src(config.sass.sourceDir + config.sass.compile, {base: 'assets'})
    .pipe(plumber())
    .pipe(sass(config.sass.options))
    .pipe(gulp.dest(config.sass.dest));
});

gulp.task('coffee', function(){
  return gulp
    .src(config.coffee.sourceDir + config.coffee.compile, {base: 'assets'})
    .pipe(plumber())
    .pipe(coffee(config.coffee.options))
    .pipe(gulp.dest(config.coffee.dest));
});

gulp.task('watch', function(){
  // watch sass file
  gulp.watch(config.sass.sourceDir + config.sass.watch, ['sass']);
  // watch coffee file
  gulp.watch(config.coffee.sourceDir + config.coffee.watch, ['coffee']);
});

gulp.task('default', ['sass', 'coffee', 'watch']);