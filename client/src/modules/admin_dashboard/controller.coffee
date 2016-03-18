Ctrl = ($scope,$rootScope,Gmap,$state,$http)->
  map = {}
  initMap = ->
    map = Gmap.initAdmiMap()
    $http.get("/api/searches").
      success (data)->
        $scope.collection = data
        $scope.temp = {from: [], to: []}
        for obj,i in data.from
          map.drawCircle(obj)
          $scope.temp.from.push(obj) if i < 10

        for obj,i in data.to
          map.drawCircle(obj)
          $scope.temp.to.push(obj) if i < 10

  initMap()

Ctrl.$inject = ['$scope','$rootScope','Gmap','$state','$http']
angular.module('client').controller('AdminDashboardCtrl', Ctrl)
