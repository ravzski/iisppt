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

    if !!attrs.gmapCords && attrs.cordsId == "from"
      google.maps.event.addListener autocomplete, 'place_changed', ->
        $('#from_lat').val this.getPlace().geometry.location.lat()
        $('#from_lng').val this.getPlace().geometry.location.lng()


    if !!attrs.gmapCords && attrs.cordsId == "to"
      google.maps.event.addListener autocomplete, 'place_changed', ->
        $('#to_lat').val this.getPlace().geometry.location.lat()
        $('#to_lng').val this.getPlace().geometry.location.lng()

    return
