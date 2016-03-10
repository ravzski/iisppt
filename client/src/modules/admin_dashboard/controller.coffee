citymap =
  chicago:
    center:
      lat: 14.5495
      lng: 121.027
    population: 2714856
  newyork:
    center:
      lat: 40.714
      lng: -74.005
    population: 8405837
  losangeles:
    center:
      lat: 34.052
      lng: -118.243
    population: 3857799
  vancouver:
    center:
      lat: 49.25
      lng: -123.1
    population: 603502


Ctrl = ($scope,$rootScope,Gmap,$state)->
  map = {}
  initMap = ->
    map = new (google.maps.Map)(document.getElementById('admin-map'),
      zoom: 14
      center:
        lat: 14.5800
        lng: 121.0000)

    # $http.get("/api/searches").$promise
    for city of citymap
      cityCircle = new (google.maps.Circle)(
        strokeColor: '#3C4CA5'
        strokeOpacity: 0.8
        strokeWeight: 1
        fillColor: '#3C4CA5'
        fillOpacity: 0.35
        map: map
        center: citymap[city].center
        radius: 50)

  initMap()
Ctrl.$inject = ['$scope','$rootScope','Gmap','$state']
angular.module('client').controller('AdminDashboardCtrl', Ctrl)
