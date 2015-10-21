module.exports = (grunt) ->

    # Project configuration
    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json')

        coffee:
            build:
                files:
                    'build/fsm.js': 'src/fsm.coffee'

            spec:
                files:
                    'spec/spec-helper.js': 'src/spec/spec-helper.coffee'
                    'spec/fsm-spec.js': 'src/spec/fsm-spec.coffee'

        uglify:
            options:
                banner: '/*! <%= pkg.name %> v<%= pkg.version %> by <%= pkg.author.name %> <<%= pkg.author.email %>> (<%= pkg.author.url %>) */\n'
                mangle: false

            build:
                src: 'build/fsm.js'
                dest: 'build/fsm.min.js'

        jasmine:
            fsm:
                src: ['build/fsm.js']
                options:
                    specs: 'spec/fsm-spec.js'
                    helpers: 'spec/spec-helper.js'

        watch:
            build:
                files: ['src/fsm.coffee']
                tasks: ['build']

            spec:
                files: ['src/spec/*.coffee']
                tasks: ['spec']
    })

    # Plug-ins
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'

    # Tasks
    grunt.registerTask 'build', [
        'coffee:build'
        'uglify:build'
    ]

    grunt.registerTask 'spec', [
        'coffee:spec'
    ]

    grunt.registerTask 'watch-build', ['watch:build']
    grunt.registerTask 'watch-spec', ['watch:spec']