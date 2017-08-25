var gulp = require('gulp');
var prettify = require('gulp-html-prettify');

gulp.task('default', function() {
  gulp.src('./out/**/*.html')
    .pipe(prettify({indent_char: ' ', indent_size: 4}))
    .pipe(gulp.dest('./out/'))
});
