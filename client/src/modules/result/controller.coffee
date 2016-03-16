Ctrl = ($scope,$state,Gmap,$http,$rootScope,$timeout,$sce,Rating,Search,Direction)->

  markerArray = []
  stepDisplay = new google.maps.InfoWindow
  $scope.currentIndex = 0
  $rootScope.headerClass = ""
  $scope.uiState =
    noRoute: false
    showRating: false
    showDirection: false
    customRoute: false

  $scope.routes = null
  $scope.query =
    from: $state.params.from
    to: $state.params.to
    departure_time: $state.params.departure_time || moment().format(DATE_FORMAT)
    bus: if $state.params.bus == "true" then true else false
    rail: if $state.params.rail == "true" then true else false
    via: ''
    time: $state.params.time || new Date().valueOf()

  $scope.form = {}

  availableRoutes = []
  directionsDisplay = new (google.maps.DirectionsRenderer)
  directionsService = new (google.maps.DirectionsService)
  map = {}
  lats = []
  lngs = []

  initMap = ->
    map = Gmap.initMap()
    directionsDisplay.setMap map
    directionsDisplay.setPanel document.getElementById('direction-panel')
    $scope.calculateAndDisplayRoute()


  $scope.calculateAndDisplayRoute = ->
    return unless $scope.isFormValid()

    $scope.uiState.showDirection = false
    directionsService.route directionOptions(), (response, status) ->
      if status == google.maps.DirectionsStatus.OK
        directionsDisplay.setDirections response
        availableRoutes = response.routes
        $scope.saveSearch(response.routes[0].legs[0])
        $timeout (->
          $scope.buildAvaiableRoutes(response.routes)
          $scope.extractKeyLocations(0)
        ), 500
      else
        $scope.uiState.noRoute = true
        $scope.$apply()

  $scope.saveSearch =(leg)->
    from =
      lat: leg.start_location.lat()
      lng: leg.start_location.lng()
      place: $scope.query.from
      orientation: true

    to =
      lat: leg.end_location.lat()
      lng: leg.end_location.lng()
      place: $scope.query.to
      orientation: false

    Search.save(from: from, to: to)

  $scope.extractKeyLocations =(index)->
    lat = []
    lng = []
    for obj in availableRoutes[index].legs[0].steps
      lat.push obj.start_location.lat()
      lng.push obj.start_location.lng()
      createMarkers(obj)
    $scope.custom_routes = []

    $http.get("/api/search",{params: "lat[]": lat, "lng[]": lng, from: $scope.query.from, to: $scope.query.to, route_index: $scope.currentIndex}).
      success (data)->
        for obj in data.custom_data
          obj.avg = obj.sum_ratings/obj.total_rating
          obj.transporations = if !!obj.transporations then  obj.transporations.split(",") else []
          $scope.custom_routes.push obj
        $scope.buildEvents(data.gmap_data.collection)
        $scope.currentRating = data.gmap_data.rating
        $scope.uiState.showDirection = true
        $scope.uiState.noRoute = false

  $scope.buildAvaiableRoutes=(routes)->
    $scope.routes= []
    ratings = null
    Rating.query(from: $scope.query.from, to: $scope.query.to).$promise
      .then (data) ->
        for obj,i in $('.adp-list ol li')
          count = 0
          sum = 0
          fare = if !!routes[i].fare then routes[i].fare.value else null
          for r in data
            if r.route_index == i
              sum = r.ratings_sum
              count = r.ratings_count
              break

          temp =
            template: obj.innerHTML
            index: i
            avg: if sum == 0  then 0 else (sum/count)
            count: count
            fare: if !!fare then "Total Cost: #{fare} PHP" else null

          $scope.routes.push temp

  $scope.hasTransporation =(transporations,ref)->
    if transporations.indexOf(ref) == -1 then false else true

  $scope.buildEvents =(data)->
    $('.event-panel').remove()
    for obj in data
      lats = []
      lngs = []
      element = $("[data-step-index=#{obj.step_index}] td")
      element.append(map.eventPanel(obj))


  $scope.changeRoutes =(index)->
    $scope.uiState.showDirection = false
    $scope.uiState.customRoute = false
    $scope.currentIndex = index
    $("[data-route-index=#{index}]").click()
    $timeout (->
      $scope.extractKeyLocations(index)
    ), 500


  $scope.legLabel =(obj)->
    label = []
    label.push "Fare: #{obj.fare.toFixed(2)} PHP" if obj.fare !=0
    label.push "Duration: #{obj.duration} mins" if obj.duration !=0
    label.join(" | ")

  $scope.isFormValid = ->
    $scope.form.from = if $scope.query.from.trim() == ''  then true else false
    $scope.form.to = if $scope.query.to.trim() == '' then true else false
    if $scope.form.from || $scope.form.to
      $.growl.error {message: MESSAGES.FORM_ERROR}
      return false
    if !$scope.query.bus && !$scope.query.rail
      $.growl.error {message: MESSAGES.INVALID_TRANSIT}
      return false
    true

  $scope.currentTimeLabel =(duration)->
    end = moment(this.query.time, ["h:mm A"]).add(duration, 'minutes')
    "#{this.query.time}–#{end.format('hh:mm A')}"

  $scope.totalDurationLabel=(duration)->
    "#{duration} mins"

  $scope.showCustomRoute =(id)->
    $scope.currentIndex = id
    $scope.uiState.customRoute = true
    Direction.get({id: id, complete: true}).$promise
      .then (data) ->
        $scope.custom_legs = data.legs

  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()
    return unless $scope.isFormValid()
    $state.go("site.result", $scope.query)

  createMarkers =(obj)->
    marker = new (google.maps.Marker)
    markerArray.push marker
    marker.setMap map
    marker.setPosition obj.start_location
    attachInstructionText stepDisplay, marker, obj.instructions, map

  directionOptions = ->
    time= moment("#{$scope.query.time}", ["h:mm A"]).format("HH:mm");
    opt =
      origin: $scope.query.from
      destination: $scope.query.to
      travelMode: google.maps.TravelMode.TRANSIT
      provideRouteAlternatives: true
      optimizeWaypoints: true
      transitOptions:
        modes: getModes()
        departureTime: new Date("#{$scope.query.departure_time} #{time}")
    opt

  attachInstructionText = (stepDisplay, marker, text, map) ->
    google.maps.event.addListener marker, 'click', ->
      # Open an info window when the marker is clicked on, containing the text
      # of the step.
      stepDisplay.setContent text
      stepDisplay.open map, marker

  getModes = ->
    modes = []
    modes.push "BUS" if $scope.query.bus
    modes.push "RAIL" if $scope.query.rail
    modes

  initMap()



Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope','$timeout','$sce','Rating','Search','Direction']
angular.module('client').controller('ResultCtrl', Ctrl)
