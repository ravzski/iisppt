module = angular.module("GmapAutocomplete", [])

module.directive 'gmapAutocomplete', ->

  link: ($scope, element, attrs) ->
    options =
      types: ['establishment']
      componentRestrictions: {country: 'ph'}

    new (google.maps.places.Autocomplete)(element[0], options)
