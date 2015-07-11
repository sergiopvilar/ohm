module.exports = function(grunt) {

  var path = require('path');

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    dist: __dirname + '/dist',
    src: __dirname + '/src',

    coffee: {
      options: {
        bare: true
      },
      compile: {
        files: [{
          expand: true,
          cwd: '<%=src%>',
          src: ['**/*.coffee'],
          dest: '<%=dist%>/',
          ext: '.js'
        }]
      },
      specs: {
        options: {
          bare: true
        },
        files: [{
          expand: true,
          cwd: './specs',
          src: ['**/*.coffee'],
          dest: '.tmp/specs',
          ext: '.js'
        }]
      }
    },

    sass: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%=src%>/renderer/assets/sass',
          src: ['**/*.scss'],
          dest: '<%=src%>/renderer/assets/css',
          ext: '.css'
        }]
      }
    },

    copy: {
      views: {
        expand: true,
        cwd: '<%=src%>',
        src: ['**/*.html'],
        dest: '<%=dist%>/'
      },
      css: {
        expand: true,
        cwd: '<%=src%>',
        src: ['**/*.css'],
        dest: '<%=dist%>/'
      },
      vendor: {
        expand: true,
        cwd: '<%=src%>/renderer/vendor',
        src: ['**/*'],
        dest: '<%=dist%>/renderer/vendor'
      }
    },

    clean: {
      dist: {
        src: ["<%=dist%>"]
      },
      specs: {
        src: [".tmp"]
      }
    },

    watch: {
      coffee: {
        files: ['<%=src%>/**/*.coffee', './specs/**/*.coffee'],
        tasks: ['clean:dist', 'coffee'],
        options: {
          nospawn: true,
          livereload: true
        }
      },
      sass: {
        files: ['<%=src%>/**/*.scss'],
        tasks: ['sass'],
        options: {
          nospawn: true,
          livereload: true
        }
      }
    }

  });

  grunt.registerTask('build', [
    'clean',
    'copy',
    'coffee:compile'
  ]);

};
