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


Ctrl = ($scope,$rootScope,Gmap,$state,$http)->
  map = {}
  initMap = ->
    map = new (google.maps.Map)(document.getElementById('admin-map'),
      zoom: 16
      center:
        lat: 14.5800
        lng: 121.0000)

    $http.get("/api/searches").
      success (data)->
        for obj in data
          cityCircle = new (google.maps.Circle)(
            strokeColor: getStrokeColor(obj.orientation)
            strokeOpacity: 0.5
            fillColor: getFillColor(obj.orientation)
            fillOpacity: 0.35
            map: map
            center: {lat: obj.lat, lng: obj.lng}
            radius: 50)

  getStrokeColor=(orientation)->
    if orientation then "#6C87D2" else "#60B97C"

  getFillColor=(orientation)->
    if orientation then "#7490DE" else "#74DE95"

  initMap()
Ctrl.$inject = ['$scope','$rootScope','Gmap','$state','$http']
angular.module('client').controller('AdminDashboardCtrl', Ctrl)
