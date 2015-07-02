remote = require 'remote'
app = angular.module "ohm", ['ngRoute']
path = remote.require('path')
_ = remote.require('underscore')
basePath = path.join __dirname, '..', 'browser'
ModelBuilder = remote.require path.join basePath, 'models', 'builder.js'
config = remote.require path.join basePath, 'models', 'config.js'
dialog = remote.require 'dialog'

app.config ($routeProvider, $locationProvider) ->

  $routeProvider

  .when '/albums', {
    templateUrl: 'views/albums.html',
    controller: 'AlbumsController'
  }

  .when '/setup', {
    templateUrl: 'views/setup.html',
    controller: 'SetupController' 
  }

  .otherwise {redirectTo: '/albums'}