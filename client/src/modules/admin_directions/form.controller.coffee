Ctrl = ($scope,$state,$timeout,$rootScope,Direction,Gmap,Leg)->


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
    from_lat: if !!$state.params.from_lat then $state.params.from_lat.toFloat() else ""
    from_lng: if !!$state.params.from_lng then $state.params.from_lng.toFloat() else ""
    to_lat: if !!$state.params.to_lat then $state.params.to_lat.toFloat() else ""
    to_lng:  if !!$state.params.to_lng then $state.params.to_lng.toFloat() else ""

  $scope.form = {}
  $scope.legs = []

  currentEvent = {}
  map = {}
  markers = []
  currentIndex = 0
  poly = new (google.maps.Polyline)(
    strokeColor: '#000000'
    strokeOpacity: 1.0
    strokeWeight: 3)
  path = poly.getPath()

  $scope.newLeg = {}
  $scope.facility_types = FACILITY_TYPES
  $scope.facility_types.push({label: "Walk", value: "Walk"})
  $scope.new_leg =
    transporation: $scope.facility_types[0].value

  initMap = ->
    map = Gmap.initAdmiMap()
    createMarkers({lat: $scope.query.from_lat, lng: $scope.query.from_lng},"origin") if $scope.query.from_lng !=""
    createMarkers({lat: $scope.query.to_lat, lng: $scope.query.to_lng},"origin") if $scope.query.to_lng !=""

    if $scope.query.from != "" && $scope.query.to != ""
      Direction.save(direction: $scope.query).$promise
        .then (data)->
          setPaths(data.legs)
          $scope.direction = {id: data.id}
          $scope.legs = data.legs
          $scope.uiState.searched = true

    calculateAndDisplayRoute()
    poly.setMap map
    # Add a listener for the click event
    map.addListener 'click', addLatLng

    #directionsDisplay.setMap(map)


  setPaths =(legs)->
    for obj in markers
      obj.setMap(null) if obj.title != '#origin'
    path.j = []
    path.push(new google.maps.LatLng($scope.query.from_lat, $scope.query.from_lng))
    for obj,i in legs
      path.push new google.maps.LatLng(obj.lat, obj.lng)
      createMarkers({lat: obj.lat, lng: obj.lng},i)

  createMarkers =(start_location,i)->
    marker = new (google.maps.Marker)(
      position: start_location
      title: '#'+i
      map: map)
    markers.push marker
    google.maps.event.addListener marker, 'click', (e) ->
      showMarkerDetails(this)

  showMarkerDetails =(marker)->
    currentIndex = marker.title.split("#")[1]
    $scope.new_leg = angular.copy $scope.legs[currentIndex]
    $scope.uiState.legModal = true
    $scope.$apply()

  addLatLng = (event) ->
    currentEvent = event
    $scope.new_leg =
      transporation: $scope.facility_types[0].value,
      direction_id: $scope.direction.id
      lat: event.latLng.lat()
      lng: event.latLng.lng()
    $scope.uiState.legModal = true
    $scope.$apply()

  $scope.saveLeg =->
    if !!$scope.new_leg.id
      $scope.updateLeg()
    else
      $scope.createLeg()

  $scope.deleteLeg = ->
    $scope.uiState.legModal = false
    $scope.legs.splice(currentIndex,1)
    setPaths($scope.legs)
    Leg.remove({id: $scope.new_leg.id}).$promise
    $.growl.notice {message: MESSAGES.DELETE_SUCCESS}

  $scope.updateLeg = ->
    $scope.uiState.legModal = false
    $scope.legs[currentIndex] = $scope.new_leg
    Leg.update({id: $scope.new_leg.id}, leg: $scope.new_leg).$promise
    $.growl.notice {message: MESSAGES.UPDATE_SUCCESS}

  $scope.createLeg = ->
    $scope.uiState.submit = true
    Leg.save(leg: $scope.new_leg).$promise
      .then (data)->
        $scope.new_leg.id = data.id
        $scope.legs.push $scope.new_leg
        $.growl.notice {message: MESSAGES.CREATE_SUCCESS}
        path.push currentEvent.latLng
        $scope.uiState.legModal = false
        unless path.length == 1
          marker = new (google.maps.Marker)(
            position: currentEvent.latLng
            title: "##{path.getLength()-2}"
            map: map)
          markers.push marker
          google.maps.event.addListener marker, 'click', (e) ->
            showMarkerDetails(this)
      .finally ->
        $scope.uiState.submit = false

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

  $scope.legLabel =(obj)->
    "#{obj.transporation} | Fare: #{obj.fare}"

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


Ctrl.$inject = ['$scope','$state','$timeout','$rootScope','Direction','Gmap','Leg']
angular.module('client').controller('AdminDirectionsFormCtrl', Ctrl)
