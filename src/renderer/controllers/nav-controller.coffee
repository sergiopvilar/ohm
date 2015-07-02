
app.controller 'NavController', ($scope, $location, $rootScope) ->
  $scope.showSidebar = true  
  $rootScope.$on '$routeChangeSuccess', (e, current, pre) ->    
    if $location.path().indexOf('setup') > -1
      $scope.showSidebar = false
     