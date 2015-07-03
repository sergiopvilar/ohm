
app.controller 'AlbumsController', ($scope, AlbumFactory) ->

  $scope.albums = AlbumFactory.all()

  AlbumFactory.on 'updated', ->
    $scope.albums = AlbumFactory.all()

    $scope.$apply()
