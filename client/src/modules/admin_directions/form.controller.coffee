Ctrl = ($scope,$state,$timeout,$rootScope,Direction,Gmap)->


  directionsService = new google.maps.DirectionsService
  directionsDisplay = new google.maps.DirectionsRenderer;

  $scope.uiState =
    pagination: false
    page: 1
    modal: false
    searched: false
    legModal: false

  $scope.query =
    from: $state.params.from || ""
    to: $state.params.to || ""
    from_lat: $state.params.from_lat.toFloat() || ""
    from_lng: $state.params.from_lng.toFloat() || ""
    to_lat: $state.params.to_lat.toFloat() || ""
    to_lng:  $state.params.to_lng.toFloat() || ""

  $scope.form = {}
  $scope.legs = []

  currentEvent = {}
  map = {}
  poly = new (google.maps.Polyline)(
    strokeColor: '#000000'
    strokeOpacity: 1.0
    strokeWeight: 3)
  path = poly.getPath()
  path.push(new google.maps.LatLng($scope.query.from_lat, $scope.query.from_lng))

  $scope.newLeg = {}
  $scope.facility_types = FACILITY_TYPES
  $scope.facility_types.push({label: "Walk", value: "Walk"})
  $scope.new_leg =
    transporation: $scope.facility_types[0].value

  initMap = ->
    map = Gmap.initAdmiMap()
    createMarkers({lat: $scope.query.from_lat, lng: $scope.query.from_lng}) if $scope.query.from_lng !=""
    createMarkers({lat: $scope.query.to_lat, lng: $scope.query.to_lng}) if $scope.query.to_lng !=""

    if $scope.query.from != "" && $scope.query.to != ""
      Direction.save(direction: $scope.query).$promise
        .then (data)->
          $scope.legs = data.legs
          $scope.uiState.searched = true

    calculateAndDisplayRoute()
    poly.setMap map
    # Add a listener for the click event
    map.addListener 'click', addLatLng

    #directionsDisplay.setMap(map)


  createMarkers =(start_location)->
    marker = new (google.maps.Marker)
    marker.setMap map
    marker.setPosition start_location

  addLatLng = (event) ->
    currentEvent = event
    $scope.new_leg = {}
    $scope.uiState.legModal = true
    $scope.$apply()

  $scope.createLeg =(form)->
    path.push currentEvent.latLng
    $scope.uiState.legModal = false
    unless path.length == 1
      marker = new (google.maps.Marker)(
        position: currentEvent.latLng
        title: '#' + path.getLength()
        map: map)


  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()

    $scope.form.from = if $scope.query.from.trim() == ''  then true else false
    $scope.form.to = if $scope.query.to.trim() == '' then true else false

    if $scope.form.from || $scope.form.to
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return
    else
      $state.go("admin.directions.form", $scope.prepQuery())

  $scope.prepQuery = ->
    temp =
      from_lat: $("#from_lat").val()
      from_lng: $("#from_lng").val()
      to_lat: $("#to_lat").val()
      to_lng: $("#to_lng").val()
      from: $("#origin").val()
      to: $("#destination").val()
    temp

  getModes = ->
    modes = []
    modes.push "BUS" if $scope.query.bus
    modes.push "RAIL" if $scope.query.rail
    modes


  calculateAndDisplayRoute = ->
    directionsService.route {
      origin: "St. Luke's Medical Center, Taguig"
      destination: "Robinsons Pioneer Complex, Pioneer Street, Mandaluyong, NCR, Philippines"
      travelMode: google.maps.TravelMode.DRIVING
    }, (response, status) ->
      directionsDisplay.setDirections response


  initMap()


Ctrl.$inject = ['$scope','$state','$timeout','$rootScope','Direction','Gmap']
angular.module('client').controller('AdminDirectionsFormCtrl', Ctrl)
