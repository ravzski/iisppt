module = angular.module("GmapAutocomplete", [])

module.directive 'gmapAutocomplete', ->

  link: ($scope, element, attrs) ->
    options =
      componentRestrictions: {country: 'ph'}

    autocomplete = new (google.maps.places.Autocomplete)(element[0], options)

    if !!attrs.gmapCords
      google.maps.event.addListener autocomplete, 'place_changed', ->
        $('#lat').val this.getPlace().geometry.location.lat()
        $('#lng').val this.getPlace().geometry.location.lng()
