var	gulp = require('gulp'),
	sass = require('gulp-ruby-sass'),
	autoprefixer = require('gulp-autoprefixer'),
	minifycss = require('gulp-minify-css'),
	jshint = require('gulp-jshint'),
	rename = require('gulp-rename'),
	gutil =	require('gulp-util'),
	uglify = require('gulp-uglifyjs'),
	concat = require('gulp-concat'),
    imagemin = require('gulp-imagemin'),
    ngAnnotate = require('gulp-ng-annotate'),
    steamify = require('gulp-streamify'),
    optipng = require('imagemin-optipng');


gulp.task('css', function() {
	gulp.src('css/build/sass/*.scss')
		.pipe(sass({ style: 'expanded' }).on('error', function(err) {
			console.log(err);
		}))
		.pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1'))
		.pipe(minifycss())
		.pipe(concat("build.min.css", {newLine: ''}))
		.pipe(gulp.dest('css'));
});

gulp.task('js', function() {
	gulp.src('js/build/**/*.js')
		.pipe(ngAnnotate().on('error', function(err) {
			//console.log(err);
		}))
		.pipe(steamify(uglify('build.min.js', {
			mangle: true,
			outSourceMap: true
		})).on('error', function(err) {
			//console.log(err);
		}))
		.pipe(gulp.dest('js'));
});

gulp.task('lint', function() {
	gulp.src('js/build/**/*.js')
		.pipe(jshint())
		.pipe(jshint.reporter('default'));
});

gulp.task('concat', function() {
	gulp.src([
		'js/libs/jquery-1.7.2.min.js',
		'js/libs/jquery-ui-1.10.2.min.js',
		//'js/libs/jquery-ui-1.8.22.sortable.min.js',

		'js/libs/angular.min.js',
		'js/libs/angular-route.min.js',
		'js/libs/angular-sanitize.min.js',

		'js/libs/bootstrap.min.js',
		'js/libs/moment.js',
	])
		.pipe(concat('all.min.js'))
		.pipe(gulp.dest('js'));
});

gulp.task('image', function () {
    gulp.src('img/**/*')
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [optipng()]
        }))
        .pipe(gulp.dest('img'));
});

gulp.task('watch', function() {
	//	Watch the sass files
	gulp.watch('css/build/sass/**/*.scss', ['css']);
	gulp.watch('js/build/**/*.js', ['lint', 'js']);

});

gulp.task('default', ['image', 'css', 'js'], function() {
});