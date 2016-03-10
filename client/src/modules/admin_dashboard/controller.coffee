Ctrl = ($scope,$rootScope,Gmap,$state)->
  map = {}
  initMap = ->
    map = new (google.maps.Map)(document.getElementById('admin-map'),
      zoom: 14
      center:
        lat: 14.5800
        lng: 121.0000)

    # $http.get("/api/searches").$promise

  initMap()
Ctrl.$inject = ['$scope','$rootScope','Gmap','$state']
angular.module('client').controller('AdminDashboardCtrl', Ctrl)
