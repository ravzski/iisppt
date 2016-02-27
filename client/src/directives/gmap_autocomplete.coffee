module = angular.module("GmapAutocomplete", [])

module.directive 'gmapAutocomplete', ->

  link: ($scope, element, attrs) ->
    new (google.maps.places.Autocomplete)(element[0], types: [ 'geocode' ])
