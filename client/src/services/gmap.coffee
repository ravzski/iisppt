angular.module('client').factory 'Gmap',
  ['$resource','$rootScope','$window'
  ($resource, $rootScope, $window) ->


    Gmap = $resource "https://maps.googleapis.com", {key: GMAP_API_KEY},
      {
        directions:
          method: 'GET'
          url: 'https://maps.googleapis.com/maps/api/directions/json'

      }

    Gmap.initMap = ->
      new (google.maps.Map)(document.getElementById('map'),
        zoom: 7
        center:
          lat: 14.5800
          lng: 121.0000)
    Gmap
  ]
