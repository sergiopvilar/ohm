app.controller 'SetupController', ($scope) ->

  dropbox = remote.require path.join basePath, 'core', 'auth.js'

  $scope.path = '/'
  $scope.folders = []
  $scope.loading = false
  
  # Listeners
  dropbox.on 'error', (error) ->
    console.log error
    dialog.showMessageBox remote.getCurrentWindow(), {
      type: 'warning',
      title: 'Error',
      message: 'Theres a problem authenticating with Dropbox',
      buttons: ['Ok']
    }

  dropbox.on 'athenticated', () ->
    $scope.step = 2
    do listDir
    do $scope.$apply

  # Methods
  
  listDir = () ->
    $scope.loading = true
    dropbox.client.readdir $scope.path, (error, entries) ->
      $scope.folders = entries
      $scope.loading = false
      $scope.$apply()

  $scope.authorize = () ->
    do dropbox.auth

  $scope.savePath = () ->
    config.set 'folder', $scope.path
    remote.getCurrentWindow().setSize 1024, 600
    window.location.href = 'index.html'

  $scope.setPath = (folder, base = "") ->
    $scope.path = base + folder + "/"

  # Initialization
  if config.get('credentials') and !config.get('folder')
    $scope.step = 2
    do listDir
  else
    $scope.step = 1

  $scope.$watch 'path', () ->
    do listDir