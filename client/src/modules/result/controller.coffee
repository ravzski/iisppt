Ctrl = ($scope,$state,Gmap,$http,$rootScope,$timeout)->

  $scope.currentIndex = 0
  $rootScope.headerClass = ""
  $scope.uiState =
    noRoute: false
    showRating: false
  $scope.routes = null
  $scope.query =
    from: $state.params.from
    to: $state.params.to
    departure_time: $state.params.departure_time || moment().format(DATE_FORMAT)
    bus: if $state.params.bus == "true" then true else false
    rail: if $state.params.rail == "true" then true else false
    via: ''
    time: $state.params.time || new Date().valueOf()

  directionsDisplay = new (google.maps.DirectionsRenderer)
  directionsService = new (google.maps.DirectionsService)

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
    $scope.uiState.showRating = false
    time= moment("#{$scope.query.time}", ["h:mm A"]).format("HH:mm");
    directionsService.route {
      origin: $scope.query.from
      destination: $scope.query.to
      travelMode: google.maps.TravelMode.TRANSIT
      provideRouteAlternatives: true
      optimizeWaypoints: true
      transitOptions:
        modes: getModes()
        departureTime: new Date("#{$scope.query.departure_time} #{time}")
    }, (response, status) ->
      $scope.uiState.noRoute = true
      if status == google.maps.DirectionsStatus.OK
        directionsDisplay.setDirections response
        $timeout (->
          $scope.extractKeyLocations(response.routes,0)
        ), 500
      else
        $scope.uiState.noRoute = true
        $scope.$apply()

  $scope.extractKeyLocations =(routes,index)->
    lat = []
    lng = []
    for obj in routes[index].legs[0].steps
      lat.push obj.start_location.lat()
      lng.push obj.start_location.lng()

    $http.get("/api/search",{params: "lat[]": lat, "lng[]": lng}).
      success (data)->
        for obj in data
          element = $("[data-step-index=#{obj.step_index}] td")
          element.append(buildEventPanel(obj))
        # for obj in data
        #   unless !!$scope.routes[$scope.currentIndex].legs[0].steps[obj.step_index][obj.info_type]
        #     $scope.routes[$scope.currentIndex].legs[0].steps[obj.step_index][obj.info_type] =
        #       events: obj.events

        $scope.uiState.showRating = true
        $scope.uiState.noRoute = false
        # for location in data
        #   for obj in $('.adp-substep').find('b')
        #     if obj.textContent != '' && location.request_place == obj.textContent
        #       $(obj.parentElement).append('<td>'+location.event+'</td>')
        #       break

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


Ctrl.$inject = ['$scope','$state','Gmap','$http','$rootScope','$timeout']
angular.module('client').controller('ResultCtrl', Ctrl)
