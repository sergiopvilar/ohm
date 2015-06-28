remote = require 'remote'
app = angular.module "ohm", ['ngRoute']
path = remote.require('path')
_ = remote.require('underscore')
ModelBuilder = remote.require path.join __dirname, '..', 'browser', 'models', 'builder.js'

app.config ($routeProvider, $locationProvider) ->

  $routeProvider

  .when('/albums', {
    templateUrl: 'views/albums.html',
    controller: 'AlbumsController'
  })

  .otherwise {redirectTo: '/albums'}