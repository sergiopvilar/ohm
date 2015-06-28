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

    copy: {
      views: {
        expand: true,
        cwd: '<%=src%>',
        src: ['**/*.html'],
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
      }
    }

  });

  grunt.registerTask('build', [
    'clean',
    'copy',
    'coffee:compile'    
  ]);

};