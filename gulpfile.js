var config = require('./config.json');
var gulp = require('gulp');
var sass = require('gulp-sass');
var plumber = require('gulp-plumber');

gulp.task('sass', function(){
  return gulp
    .src(config.sass.sourceDir + config.sass.compile, {base: 'assets'})
    .pipe(plumber())
    .pipe(sass(config.sass.options))
    .pipe(gulp.dest(config.sass.dest));
});

gulp.task('watch', function(){
  gulp.watch(config.sass.sourceDir + config.sass.watch, ['sass']);
});