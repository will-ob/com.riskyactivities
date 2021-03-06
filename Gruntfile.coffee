
# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'


# 
# app/
#   _lib/
#      main.scss
#   _includes/
#   index.jade
#
# dist/
# vendor/bower/
#

module.exports = (grunt) ->
  # show elapsed time at the end
  require('time-grunt')(grunt)
  # load all grunt tasks
  require('load-grunt-tasks')(grunt)
  pygmentize = require('pygmentize-bundled')

  # configurable paths
  yeomanConfig =
    app: 'app'
    dist: 'dist'

  grunt.initConfig
    yeoman: yeomanConfig,
    watch:
      coffee:
        files: ['<%= yeoman.app %>/{,*/}*.coffee']
        tasks: ['coffee:dist']
      coffeeTest:
        files: ['test/spec/{,*/}*.coffee']
        tasks: ['coffee:test']
      compass:
        files: ['<%= yeoman.app %>/{,*/}*.{scss,sass}']
        tasks: ['compass:server', 'autoprefixer']
      styles:
        files: ['<%= yeoman.app %>/styles/{,*/}*.css']
        tasks: ['copy:styles', 'autoprefixer']
      jade:
        files: ['<%= yeoman.app %>/{,*/}*.jade']
        tasks: ['jade:dist']
      markdown:
        files: [
          '<%= yeoman.app %>/{,*/}*.md',
          '<%= yeoman.app %>/article-tmpl.jade',
          '<%= yeoman.app %>/includes/{,*/}*.jade'
        ]
        tasks: ['markdown']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: [
          '<%= yeoman.dist %>/*.html'
          '<%= yeoman.dist %>/styles/{,*/}*.css'
          '<%= yeoman.dist %>/scripts/{,*/}*.js'
          '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
        ]

    connect:
      options:
        port: 9000
        livereload: 35729
        # change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'

      test:
        options:
          base: [
            '.tmp',
            'test',
            yeomanConfig.app
          ]

      dist:
        options:
          open: true,
          base: yeomanConfig.dist

    clean:
      dist:
        files: [{
          dot: true,
          src: [
            '.tmp'
            '<%= yeoman.dist %>/*'
            '!<%= yeoman.dist %>/.git*'
          ]
        }]

      #   server: '.tmp'

    jade:
      markdownTmp:
        options:
          pretty: true
        files: [{
          src: 'app/article-tmpl.jade',
          dest: '.tmp/article-tmpl.jst'
        }]

      dist:
        options:
          pretty: true
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>',
          src: '{,*/}*.jade',
          dest: '<%= yeoman.dist %>',
          ext: '.html'
        }]

      # jshint:
      #   options:
      #     jshintrc: '.jshintrc'

      #   all: [
      #     'Gruntfile.js',
      #     '<%= yeoman.app %>/scripts/{,*/}*.js',
      #     '!<%= yeoman.app %>/scripts/vendor/*',
      #     'test/spec/{,*/}*.js'
      #   ]

      # mocha:
      #   all:
      #     options:
      #       run: true,
      #       urls: ['http://<%= connect.test.options.hostname %>:<%= connect.test.options.port %>/index.html']

    coffee:
      dist:
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/scripts',
          src: '{,*/}*.coffee',
          dest: '<%= yeoman.dist %>/scripts',
          ext: '.js'
        }]

      test:
        files: [{
          expand: true,
          cwd: 'test/spec',
          src: '{,*/}*.coffee',
          dest: '.tmp/spec',
          ext: '.js'
        }]


    compass:
      options:
        sassDir: '<%= yeoman.app %>',
        cssDir: '<%= yeoman.dist %>/styles',
    #     generatedImagesDir: '.tmp/images/generated',
    #     imagesDir: '<%= yeoman.app %>/images',
    #     javascriptsDir: '<%= yeoman.app %>/scripts',
    #     fontsDir: '<%= yeoman.app %>/styles/fonts',
        importPath: 'vendor/bower',
    #     httpImagesPath: '/images',
    #     httpGeneratedImagesPath: '/images/generated',
    #     httpFontsPath: '/styles/fonts',
    #     relativeAssets: false

    #   dist:
    #     options:
    #       generatedImagesDir: '<%= yeoman.dist %>/images/generated'


      server:
        options:
          debugInfo: true



    autoprefixer:
      options:
        browsers: ['last 1 version']

      dist:
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]


    concat:
      dist:
        src: [
          'vendor/bower/requirejs/require.js'
          '.tmp/scripts/required.js'
        ]
        dest: yeomanConfig.dist + '/scripts/required.js'

    requirejs:
      dist:
        # Options: https://github.com/jrburke/r.js/blob/master/build/example.build.js
        options:
          mainConfigFile: yeomanConfig.dist + '/scripts/config.js'
          out: yeomanConfig.dist + '/scripts/required.js'
          optimize: 'none'



    # rev:
    #   dist:
    #     files:
    #       src: [
    #         '<%= yeoman.dist %>/scripts/{,*/}*.js',
    #         '<%= yeoman.dist %>/styles/{,*/}*.css',
    #         '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
    #         '<%= yeoman.dist %>/styles/fonts/{,*/}*.*'
    #       ]



    # useminPrepare:
    #   options:
    #     dest: '<%= yeoman.dist %>'

    #   html: '<%= yeoman.app %>/index.html'

    # usemin:
    #   options:
    #     dirs: ['<%= yeoman.dist %>']

    #   html: ['<%= yeoman.dist %>/{,*/}*.html'],
    #   css: ['<%= yeoman.dist %>/styles/{,*/}*.css']

    # imagemin:
    #   dist:
    #     files: [{
    #       expand: true,
    #       cwd: '<%= yeoman.app %>/images',
    #       src: '{,*/}*.{png,jpg,jpeg}',
    #       dest: '<%= yeoman.dist %>/images'
    #     }]


    # svgmin:
    #   dist:
    #     files: [{
    #       expand: true,
    #       cwd: '<%= yeoman.app %>/images',
    #       src: '{,*/}*.svg',
    #       dest: '<%= yeoman.dist %>/images'
    #     }]


    # # cssmin:
    #   # This task is pre-configured if you do not wish to use Usemin
    #   # blocks for your CSS. By default, the Usemin block from your
    #   # `index.html` will take care of minification, e.g.
    #   #   <!-- build:css({.tmp,app) styles/main.css -->
    #   # dist:
    #   #   files:
    #   #     '<%= yeoman.dist %>/styles/main.css': [
    #   #       '.tmp/styles/{,*/}*.css',
    #   #       '<%= yeoman.app %>/styles/{,*/}*.css'
    #   #     ]
    #   #
    #   #

    # htmlmin:
    #   dist:
    #     # options:
    #      #  /*removeCommentsFromCDATA: true,
    #      #  # https://github.com/yeoman/grunt-usemin/issues/44
    #      #  //collapseWhitespace: true,
    #      #  collapseBooleanAttributes: true,
    #      #  removeAttributeQuotes: true,
    #      #  removeRedundantAttributes: true,
    #      #  useShortDoctype: true,
    #      #  removeEmptyAttributes: true,
    #      #  removeOptionalTags: true*/

    #     files: [
    #       {
    #         expand: true,
    #         cwd: '<%= yeoman.app %>',
    #         src: '*.html',
    #         dest: '<%= yeoman.dist %>'
    #       },
    #       {
    #         expand: true,
    #         cwd: '.tmp',
    #         src: '*.html',
    #         dest: '<%= yeoman.dist %>'
    #       }
    #     ]

    markdown:
      all:
        files: [
          {
            expand: true,
            cwd: 'app'
            src: '**/*.md'
            flatten: false
            dest: '<%= yeoman.dist %>/'
            ext: '.html'
          }
        ],
        options:
          template: '.tmp/article-tmpl.jst'
          # preCompile: (src, context) ->
          #   console.log "pre comp"
          # postCompile: (src, context) ->
          #   console.log "post comp"
          templateContext: {}
          markdownOptions:
            gfm: true

    # # Put files not handled in other tasks here
    copy:
      dist:
        files: [{
          expand: true
          flatten: false
          cwd: "<%= yeoman.app %>" 
          src: [
            "CNAME"
            "*.txt"
          ]
          dest: "<%= yeoman.dist %>/"
        }, {
          expand: true,
          flatten: true
          src: [
            'vendor/bower/modernizr/modernizr.js'
            'vendor/bower/MathJax/MathJax.js'
          ]
          dest: '<%= yeoman.dist %>/vendor/scripts/',
        }, {
          expand: true,
          flatten: true
          src: [
            'vendor/bower/highlightjs/styles/github.css'
          ]
          dest: '<%= yeoman.dist %>/vendor/styles/',
        }]

    # modernizr:
    #   devFile: '<%= yeoman.app %>/bower_components/modernizr/modernizr.js',
    #   outputFile: '<%= yeoman.dist %>/bower_components/modernizr/modernizr.js',
    #   files: [
    #     '<%= yeoman.dist %>/scripts/{,*/}*.js',
    #     '<%= yeoman.dist %>/styles/{,*/}*.css',
    #     '!<%= yeoman.dist %>/scripts/vendor/*'
    #   ],
    #   uglify: true

    # concurrent:
    #   server: [
    #     'compass',
    #     'coffee:dist',
    #     'jade',
    #     'htmlmin',
    #     'copy:styles'
    #   ],
    #   test: [
    #     'coffee',
    #     'copy:styles'
    #   ],
    #   dist: [
    #     'coffee',
    #     'jade',
    #     'compass',
    #     'copy:styles',
    #     'imagemin',
    #     'svgmin',
    #     'htmlmin'
    #   ]

    # bower:
    #   options:
    #     exclude: ['modernizr']

    #   all:
    #     rjsConfig: '<%= yeoman.app %>/scripts/main.js'

    grunt.registerTask('server', (target) ->

      grunt.task.run([
        'build',
        'connect:dist',
        'watch'
        # 'clean:server',
        # 'concurrent:server',
        # 'autoprefixer',
        # 'connect:livereload',
        # 'watch'
      ])
    )

    # grunt.registerTask('test', [
    #   'clean:server',
    #   'concurrent:test',
    #   'autoprefixer',
    #   'connect:test',
    #   'mocha'
    # ])

    grunt.registerTask('build', [
      'clean:dist'
      'compass'
      'coffee:dist'
      'jade'
      'markdown'
      'requirejs'
      'concat'
      'copy'
    #   'useminPrepare',
    #   'concurrent:dist',
    #   'autoprefixer',
    #   'requirejs',
    #   'concat',
    #   'cssmin',
    #   'uglify',
    #   'modernizr',
    #   'copy:dist',
    #   'rev',
    #   'usemin'
    ])

    grunt.registerTask('default', [
      #'test',
      'build'
    ])
