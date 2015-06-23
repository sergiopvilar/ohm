module.exports = function(grunt) {
  
  var path = require('path');

  require('load-grunt-tasks')(grunt);  

  grunt.initConfig({

    dist: __dirname + '/dist',
    src: __dirname + '/src',

    coffee: {
      compile: {
        files: [{
          expand: true,
          cwd: '<%=src%>',
          src: ['**/*.coffee'],
          dest: '<%=dist%>/',
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
    },

    clean: {
      dist: {
        src: ["<%=dist%>"]
      }      
    },

    watch: {
      coffee: {
        files: ['<%=src%>/**/*.coffee'],
        tasks: ['clean', 'coffee'],
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