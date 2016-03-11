Ctrl = ($scope,$rootScope,Gmap,$state,$http)->
  map = {}
  initMap = ->
    map = Gmap.initAdmiMap()
    $http.get("/api/searches").
      success (data)->
        $scope.collection = data
        for obj in data.from
          map.drawCircle(obj)

        for obj in data.to
          map.drawCircle(obj)

  initMap()

Ctrl.$inject = ['$scope','$rootScope','Gmap','$state','$http']
angular.module('client').controller('AdminDashboardCtrl', Ctrl)
