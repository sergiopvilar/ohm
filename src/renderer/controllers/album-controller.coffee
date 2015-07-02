
app.controller 'AlbumsController', ($scope, AlbumFactory) ->

  $scope.albums = AlbumFactory.all()-

  console.log AlbumFactory.value()

  AlbumFactory.on 'updated', ->
    $scope.albums = AlbumFactory.all()
    $scope.$apply()
