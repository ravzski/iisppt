Ctrl = ($scope,$state,Gmap,$http,$rootScope,$timeout,$sce,Rating)->

  markerArray = []
  stepDisplay = new google.maps.InfoWindow
  $scope.currentIndex = 0
  $rootScope.headerClass = ""
  $scope.uiState =
    noRoute: false
    showRating: false
    showDirection: false

  $scope.routes = null
  $scope.query =
    from: $state.params.from
    to: $state.params.to
    departure_time: $state.params.departure_time || moment().format(DATE_FORMAT)
    bus: if $state.params.bus == "true" then true else false
    rail: if $state.params.rail == "true" then true else false
    via: ''
    time: $state.params.time || new Date().valueOf()

  availableRoutes = []
  directionsDisplay = new (google.maps.DirectionsRenderer)
  directionsService = new (google.maps.DirectionsService)
  map = {}

  initMap = ->
    map = new (google.maps.Map)(document.getElementById('map'),
      zoom: 7
      center:
        lat: 14.5800
        lng: 121.0000)
    directionsDisplay.setMap map
    directionsDisplay.setPanel document.getElementById('direction-panel')
    $scope.calculateAndDisplayRoute()


  $scope.calculateAndDisplayRoute = ->
    $scope.uiState.showDirection = false
    directionsService.route directionOptions(), (response, status) ->
      $scope.uiState.noRoute = true
      if status == google.maps.DirectionsStatus.OK
        directionsDisplay.setDirections response
        availableRoutes = response.routes
        $timeout (->
          $scope.buildAvaiableRoutes()
          $scope.extractKeyLocations(0)
        ), 500
      else
        $scope.uiState.noRoute = true
        $scope.$apply()

  $scope.extractKeyLocations =(index)->
    lat = []
    lng = []
    for obj in availableRoutes[index].legs[0].steps
      lat.push obj.start_location.lat()
      lng.push obj.start_location.lng()
      createMarkers(obj)

    $http.get("/api/search",{params: "lat[]": lat, "lng[]": lng, from: $scope.query.from, to: $scope.query.to, route_index: $scope.currentIndex}).
      success (data)->
        $scope.buildEvents(data.collection)
        $scope.currentRating = data.rating
        $scope.uiState.showDirection = true
        $scope.uiState.noRoute = false

  $scope.buildAvaiableRoutes= ->
    $scope.routes= []
    ratings = null
    Rating.query(from: $scope.query.from, to: $scope.query.to).$promise
      .then (data) ->

        for obj,i in $('.adp-list ol li')
          count = 0
          sum = 0
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

          $scope.routes.push temp


  $scope.buildEvents =(data)->
    $('.event-panel').remove()
    for obj in data
      element = $("[data-step-index=#{obj.step_index}] td")
      element.append(buildEventPanel(obj))

  $scope.changeRoutes =(index)->
    $scope.uiState.showDirection = false
    $scope.currentIndex = index
    $("[data-route-index=#{index}]").click()
    $timeout (->
      $scope.extractKeyLocations(index)
    ), 500

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

  buildEventPanel =(obj)->
    events = ""
    for event in obj.events
      events+= buildEvenList(event)

    "<div class='event-panel'>
      <h4 class='title'>
        #{obj.info_type}
      </h4>
      <ul class='event-list'>
        #{events}
      </ul>
    </div>"

  buildEvenList =(event)->
    " <li>
      <div class='event-place'>
        #{event.place}
      </div>
      <div class='event-desc'>
        #{event.description}
      </div>
      <div class='event-date'>
        #{event.created_at.formatTimestamp()}
      </div>
    </li>"

  getModes = ->
    modes = []
    modes.push "BUS" if $scope.query.bus
    modes.push "RAIL" if $scope.query.rail
    modes


  initMap()

  $scope.search = ->
    $scope.query.from = $('#origin').val()
    $scope.query.to = $('#destination').val()
    $scope.query.via = $('#via').val()
    $state.go("site.result", $scope.query)


Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope','$timeout','$sce','Rating']
angular.module('client').controller('ResultCtrl', Ctrl)
