angular.module('client').factory 'Gmap',
  ['$resource','$rootScope','$window'
  ($resource, $rootScope, $window) ->


    Gmap = $resource "https://maps.googleapis.com", {key: GMAP_API_KEY},
      {
        directions:
          method: 'GET'
          url: 'https://maps.googleapis.com/maps/api/directions/json'

      }
    Gmap
  ]
